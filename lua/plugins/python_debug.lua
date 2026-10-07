-- Python adapter and project-aware ChipMind launch profiles.
local M = {}

local function project_root()
	local file = vim.api.nvim_buf_get_name(0)
	return (file ~= "" and vim.fs.root(file, "pyproject.toml"))
		or vim.fs.root(vim.fn.getcwd(), "pyproject.toml")
		or vim.fn.getcwd()
end

local function chipmind_root()
	local root = project_root()
	if vim.fn.filereadable(root .. "/openhands/server/listen.py") == 1 then
		return root
	end
	vim.notify("Open a ChipMind file or :cd to its project root before debugging the backend.", vim.log.levels.ERROR)
	return require("dap").ABORT
end

local function python_path()
	local local_python = project_root() .. "/.venv/bin/python"
	if vim.fn.executable(local_python) == 1 then
		return local_python
	end
	if vim.env.VIRTUAL_ENV and vim.fn.executable(vim.env.VIRTUAL_ENV .. "/bin/python") == 1 then
		return vim.env.VIRTUAL_ENV .. "/bin/python"
	end
	return vim.fn.exepath("python3")
end

function M.setup()
	local dap = require("dap")
	local python = require("dap-python")
	require("plugins.chipmind_make_debug").setup(dap)
	python.setup("python3", { include_configs = false })
	python.resolve_python = python_path
	python.test_runner = "pytest"

	-- Resolve the interpreter at launch time, including when changing projects.
	local adapter = dap.adapters.python
	dap.adapters.python = function(callback, config)
		if config.request == "attach" then
			adapter(callback, config)
			return
		end
		local executable = config.pythonPath or python_path()
		if executable == "" or vim.fn.executable(executable) ~= 1 then
			vim.notify("Python debugger: no interpreter found. Create the project's .venv first.", vim.log.levels.ERROR)
			return
		end
		local result = vim.system({ executable, "-c", "import debugpy" }, { text = true }):wait(10000)
		if result.code ~= 0 then
			vim.notify("Python debugger: debugpy is unavailable in " .. executable
				.. ". Run: uv pip install --python " .. vim.fn.shellescape(executable) .. " debugpy", vim.log.levels.ERROR)
			return
		end
		config.pythonPath = executable
		config.cwd = config.cwd or project_root()
		adapter(function(spec)
			spec.command = executable
			callback(spec)
		end, config)
	end
	dap.adapters.debugpy = dap.adapters.python

	dap.configurations.python = {
		{
			type = "chipmind_make",
			request = "attach",
			name = "ChipMind: Make run + debug",
			cwd = chipmind_root,
			connect = function()
				return { host = "127.0.0.1", port = tonumber(vim.env.DEBUG_PORT or "5678") }
			end,
			justMyCode = true,
		},
		{
			type = "python",
			request = "attach",
			name = "ChipMind: Attach backend",
			connect = function()
				return { host = "127.0.0.1", port = tonumber(vim.env.DEBUG_PORT or "5678") }
			end,
			cwd = chipmind_root,
			envFile = "/dev/null",
			justMyCode = true,
		},
		{
			type = "python", request = "launch", name = "Python: Current file",
			program = "${file}", cwd = project_root, pythonPath = python_path,
			console = "integratedTerminal", justMyCode = true,
		},
		{
			type = "python", request = "launch", name = "Python: Pytest current file",
			module = "pytest", args = { "-s", "${file}" }, cwd = project_root,
			pythonPath = python_path, console = "integratedTerminal", justMyCode = true,
		},
	}
	vim.keymap.set("n", "<leader>Dn", python.test_method, { desc = "[D]ebug [N]earest Python test" })
	vim.keymap.set("n", "<leader>DN", python.test_class, { desc = "[D]ebug Python test class" })
end

return M
