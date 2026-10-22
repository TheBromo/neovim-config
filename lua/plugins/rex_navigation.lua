-- Rex's init.lua hands <C-h/j/k/l> to Neovim while it is the focused program,
-- so Neovim decides when to leave: at the edge of its windows it asks Rex to
-- focus the neighbouring pane. This is a server call, so it works without
-- Remote Control.
local directions = { h = "left", j = "down", k = "up", l = "right" }

local function navigate(key, direction)
	local previous = vim.api.nvim_get_current_win()
	vim.cmd("wincmd " .. key)
	if vim.api.nvim_get_current_win() ~= previous then return end

	local session = vim.env.REX_SESSION
	if session == nil or session == "" or vim.fn.executable("rex") ~= 1 then return end
	vim.system({
		"rex", "api", "call", "-s", session,
		"session.focus_direction", vim.json.encode({ direction = direction }),
	})
end

return {
	specs = {},
	setup = function()
		for key, direction in pairs(directions) do
			vim.keymap.set("n", "<C-" .. key .. ">", function() navigate(key, direction) end, {
				desc = "Go to the " .. direction .. " window or Rex pane",
			})
		end
	end,
}
