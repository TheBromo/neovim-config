-- Centralized theme utilities module
local M = {}

-- List of available themes (synchronized with colorscheme.lua)
M.themes = {
	"monokai-pro",
	"mountain",
	"nightlamp",
	"moonfly",
	"midnight-desert",
	"ayu",
	"noctis",
	"fusion",
	"deviuspro",
	"gruvbox",
	"brightburn",
	"kanagawa",
	"light",
	"vercel",
	"vesper",
	"none",
}

-- Get the theme configuration file path
M.get_theme_file = function()
	return vim.fn.stdpath("config") .. "/.nvim_theme"
end

-- Read the current theme from file
M.get_current_theme = function()
	local theme_file = M.get_theme_file()
	local theme = "monokai-pro" -- default
	if vim.fn.filereadable(theme_file) == 1 then
		theme = vim.fn.readfile(theme_file)[1]
	end
	return theme
end

-- Save theme selection to file
M.save_theme = function(theme)
	vim.fn.writefile({ theme }, M.get_theme_file())
	vim.notify("Restart Neovim to apply " .. theme .. " theme", vim.log.levels.INFO)
	vim.cmd("restart")
end

return M

