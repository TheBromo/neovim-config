-- Make runs in an owned Herdr tab; Neovim only connects to its debug adapter.
local M = {}
local active

local function call(args, callback)
	local command = { "herdr" }
	vim.list_extend(command, args)
	return vim.system(command, { text = true }, vim.schedule_wrap(callback))
end

local function decode(result)
	local ok, data = pcall(vim.json.decode, result.stdout or "")
	return ok and data.result or nil
end

local function finish(run, dap, message)
	if active ~= run then return end
	active = nil
	if run.waiter then run.waiter:kill(15); run.waiter = nil end
	if run.ready_waiter then run.ready_waiter:kill(15); run.ready_waiter = nil end
	local session = dap.session()
	if session and session.config.type == "chipmind_make" then dap.close() end
	vim.fn.delete(run.script)
	vim.fn.delete(run.directory, "d")
	if message then vim.notify(message, vim.log.levels.WARN) end
end

local function interrupt(run)
	if run.interrupted or not run.started then return end
	run.interrupted = true
	call({ "pane", "send-keys", run.pane, "ctrl+c" }, function(result)
		if result.code ~= 0 and active == run then
			vim.notify("Could not interrupt the ChipMind Herdr tab; stopping its owned tab after the cleanup grace period.", vim.log.levels.WARN)
		end
	end)
	vim.defer_fn(function()
		if active == run then
			-- Only this run's returned tab ID is ever closed, and only if graceful stop failed.
			call({ "tab", "close", run.tab }, function(result)
				if result.code == 0 then
					finish(run, run.dap, "ChipMind did not exit within 15 seconds; closed its Herdr tab.")
				else
					vim.notify("Could not close ChipMind's Herdr tab. Stop it in Herdr before launching again.", vim.log.levels.ERROR)
				end
			end)
		end
	end, 15000)
end

function M.stop()
	local run = active
	if not run then return false end
	run.stopping = true
	interrupt(run)
	return true
end

local function write_launcher(run, config, port)
	vim.fn.mkdir(run.directory, "p", 448)
	local lines = {
		"#!/usr/bin/env bash",
		[[trap 'status=$?; printf "\nCHIPMIND_MAKE_EXIT=%s\n" "$status"; exit "$status"' EXIT]],
		[[trap 'exit 130' INT]],
		[[trap 'exit 143' TERM]],
	}
	-- Herdr starts a fresh shell. Preserve the editor's development environment in
	-- a private file instead of exposing environment values in pane commands/argv.
	for key, value in pairs(vim.fn.environ()) do
		if key:match("^[%a_][%w_]*$") and not key:match("^HERDR_") and not key:match("^NVIM")
			and not key:match("^TERM") and key ~= "COLORTERM" and key ~= "PWD"
			and key ~= "OLDPWD" and key ~= "SHLVL" and key ~= "_"
			and key ~= "SHELLOPTS" and key ~= "BASHOPTS" then
			table.insert(lines, "export " .. key .. "=" .. vim.fn.shellescape(value))
		end
	end
	table.insert(lines, "cd " .. vim.fn.shellescape(config.cwd) .. " || exit 1")
	local command = { "make", "run", "USE_VITE=1", "DEBUG_BACKEND=1", "DEBUG_PORT=" .. port }
	for _, name in ipairs({ "BACKEND_HOST", "BACKEND_PORT", "BACKEND_DEV_PORT" }) do
		if vim.env[name] and vim.env[name] ~= "" then table.insert(command, name .. "=" .. vim.env[name]) end
	end
	table.insert(lines, table.concat(vim.tbl_map(vim.fn.shellescape, command), " "))
	vim.fn.writefile(lines, run.script)
	vim.fn.setfperm(run.script, "rw-------")
end

function M.setup(dap)
	dap.adapters.chipmind_make = function(callback, config)
		if active then
			vim.notify("A ChipMind Make run is already active. Stop it with Space D t first.", vim.log.levels.WARN)
			return
		end
		if vim.env.HERDR_ENV ~= "1" or not vim.env.HERDR_WORKSPACE_ID or vim.fn.executable("herdr") ~= 1 then
			vim.notify("Start Neovim inside Herdr to launch ChipMind in a Herdr tab.", vim.log.levels.ERROR)
			return
		end
		local port = tonumber(config.connect.port)
		if not port or port < 1 or port > 65535 or port % 1 ~= 0 then
			vim.notify("DEBUG_PORT must be an integer between 1 and 65535.", vim.log.levels.ERROR)
			return
		end
		local directory = vim.fn.tempname()
		local run = { directory = directory, script = directory .. "/run.sh", dap = dap }
		local ok, err = pcall(write_launcher, run, config, port)
		if not ok then
			vim.fn.delete(run.script); vim.fn.delete(directory, "d")
			vim.notify("Could not prepare the Herdr launcher: " .. tostring(err), vim.log.levels.ERROR)
			return
		end
		active = run
		call({ "tab", "create", "--workspace", vim.env.HERDR_WORKSPACE_ID,
			"--cwd", config.cwd, "--label", "ChipMind debug :" .. port, "--no-focus" }, function(result)
			local data = decode(result)
			if result.code ~= 0 or not data or not data.root_pane or not data.tab then
				finish(run, dap, "Could not create a Herdr tab. Check the Herdr session and socket access.")
				return
			end
			run.pane, run.tab = data.root_pane.pane_id, data.tab.tab_id
			if run.stopping then finish(run, dap); return end
			call({ "pane", "run", run.pane, "bash " .. vim.fn.shellescape(run.script) }, function(started)
				if started.code ~= 0 then finish(run, dap, "Could not start Make in the new Herdr tab."); return end
				run.started = true
				local function wait_for_exit()
					run.waiter = call({ "pane", "wait-output", run.pane, "--regex", "^CHIPMIND_MAKE_EXIT=[0-9]+$",
						"--source", "recent-unwrapped" }, function(exited)
						if active ~= run then return end
						run.waiter = nil
						local match = decode(exited)
						if exited.code ~= 0 then
							-- A closed pane also ends its process; do not leave a stale DAP session.
							call({ "pane", "get", run.pane }, function(state)
								if state.code ~= 0 then finish(run, dap, "ChipMind Herdr pane is no longer available.")
								else M.stop() end
							end)
						else
							finish(run, dap, not run.stopping and ("ChipMind Make exited. See Herdr tab " .. run.tab .. ". "
								.. (match and match.matched_line or "")) or nil)
						end
					end)
				end
				wait_for_exit()
				if run.stopping then interrupt(run); return end
				vim.notify("Make is starting in Herdr tab " .. run.tab .. ". Space D t cancels; Neovim will attach automatically.")
				run.ready_waiter = call({ "pane", "wait-output", run.pane, "--regex", "^CHIPMIND_(DEBUG_READY=" .. port .. "|MAKE_EXIT=[0-9]+)$",
					"--source", "recent-unwrapped", "--timeout", "600000" }, function(ready)
					run.ready_waiter = nil
					if active ~= run or run.stopping then return end
					local match = decode(ready)
					if ready.code ~= 0 or not match then
						vim.notify("Debugger readiness failed or timed out. See the ChipMind Herdr tab.", vim.log.levels.ERROR)
						M.stop(); return
					end
					if not match.matched_line:find("CHIPMIND_DEBUG_READY=" .. port, 1, true) then return end
					callback({ type = "server", host = "127.0.0.1", port = port, options = { source_filetype = "python" } })
					vim.defer_fn(function()
						if active == run and not run.initialized and not run.stopping then
							vim.notify("Debugger did not initialize within 30 seconds.", vim.log.levels.ERROR); M.stop()
						end
					end, 30000)
				end)
			end)
		end)
	end
	dap.listeners.after.event_initialized["chipmind_make"] = function(session)
		if not active or session.config.type ~= "chipmind_make" then return end
		local run = active
		run.initialized = true
		session.on_close["chipmind_make"] = function()
			vim.schedule(function() if active == run then M.stop() end end)
		end
	end
	vim.api.nvim_create_user_command("ChipMindDebugStop", function()
		if not M.stop() then vim.notify("No Neovim-owned ChipMind Herdr run is active.") end
	end, { desc = "Stop ChipMind in its Herdr tab" })
	vim.api.nvim_create_autocmd("VimLeavePre", { callback = function()
		if active then M.stop(); vim.wait(16000, function() return active == nil end, 100) end
	end })
end

return M
