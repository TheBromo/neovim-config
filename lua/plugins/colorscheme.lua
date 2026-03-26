local theme_utils = require("theme_utils")
local theme = theme_utils.get_current_theme()

-- Define all available themes in a lookup table
local themes = {
	["monokai-pro"] = {
		"loctvl842/monokai-pro.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("monokai-pro").setup({
				terminal_colors = true,
				transparent_background = true,
				filter = "pro",
				devicons = false, -- vim.g.have_nerd_font,

				override_palette = function(filter)
					return {
						dark1 = "#121212",
						background = "#080808",
					}
				end,
			})
			vim.cmd([[colorscheme monokai-pro]])
		end,
	},
	["nightlamp"] = {
		"MinhCreator/base46.nvim",
		lazy = false,
		config = function()
			local present, base46 = pcall(require, "base46")
			if not present then
				return
			end
			base46.load_theme({ theme = "nightlamp" })
		end,
	},
	["mountain"] = {
		"mountain-theme/vim",
		lazy = false,
		config = function()
			vim.cmd([[colorscheme mountain]])
		end,
	},
	["moonfly"] = {
		"bluz71/vim-moonfly-colors",
		name = "moonfly",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.moonflyWinSeparator = 2
			vim.g.moonflyNormalFloat = true
			vim.cmd([[colorscheme moonfly]])
		end,
	},
	["midnight-desert"] = {
		"CosecSecCot/midnight-desert.nvim",
		dependencies = { "rktjmp/lush.nvim" },
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme midnight-desert]])
		end,
	},
	["ayu"] = {
		"Luxed/ayu-vim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.ayucolor = "dark"
			vim.g.ayu_italic_comment = 1
			vim.cmd([[colorscheme ayu]])
		end,
	},
	["noctis"] = {
		"kartikp10/noctis.nvim",
		lazy = false,
		priority = 1000,
		dependencies = { "rktjmp/lush.nvim" },
		config = function()
			vim.cmd([[colorscheme noctis]])
		end,
	},
	["fusion"] = {
		"lfenzo/fusion.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme fusion]])
		end,
	},
	["deviuspro"] = {
		"DeviusVim/deviuspro.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme deviuspro]])
		end,
	},
	["gruvbox"] = {
		"morhetz/gruvbox",
		name = "gruvbox",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.gruvbox_contrast_dark = "hard"
			vim.g.gruvbox_contrast_light = "hard"
			vim.cmd([[colorscheme gruvbox]])
		end,
	},
	["light"] = {
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme catppuccin-latte]])
		end,
	},
	["brightburn"] = {
		"erikbackman/brightburn.vim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme brightburn]])
		end,
	},
	["kanagawa"] = {
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("kanagawa").setup({})
			vim.cmd([[colorscheme kanagawa-dragon]])
		end,
	},
	["vercel"] = {
		"ceigh/vercel-theme.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd("colorscheme vercel")
		end,
	},
	["vesper"] = {
		"datsfilipe/vesper.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("vesper").setup({})
			vim.cmd("colorscheme vesper")
		end,
	},
}

-- Return the selected theme configuration or a fallback
local selected_theme = themes[theme]
if selected_theme then
	return { selected_theme }
else
	-- Fallback to default colorscheme if theme not found
	vim.notify("Theme '" .. theme .. "' not found, using default", vim.log.levels.WARN)
	vim.o.termguicolors = false
	vim.cmd("colorscheme default")
	return {}
end
