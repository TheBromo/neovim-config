local theme_utils = require("theme_utils")
local theme = theme_utils.get_current_theme()

local themes = {
	["monokai-pro"] = {
		spec = "https://github.com/loctvl842/monokai-pro.nvim",
		setup = function()
			require("monokai-pro").setup({
				terminal_colors = true,
				transparent_background = true,
				filter = "pro",
				devicons = false,

				override_palette = function(_)
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
		spec = "https://github.com/MinhCreator/base46.nvim",
		setup = function()
			local present, base46 = pcall(require, "base46")
			if not present then
				return
			end
			base46.load_theme({ theme = "nightlamp" })
		end,
	},
	["mountain"] = {
		spec = "https://github.com/mountain-theme/vim",
		setup = function()
			vim.cmd([[colorscheme mountain]])
		end,
	},
	["moonfly"] = {
		spec = { src = "https://github.com/bluz71/vim-moonfly-colors", name = "moonfly" },
		setup = function()
			vim.g.moonflyWinSeparator = 2
			vim.g.moonflyNormalFloat = true
			vim.cmd([[colorscheme moonfly]])
		end,
	},
	["midnight-desert"] = {
		specs = {
			"https://github.com/rktjmp/lush.nvim",
			"https://github.com/CosecSecCot/midnight-desert.nvim",
		},
		setup = function()
			vim.cmd([[colorscheme midnight-desert]])
		end,
	},
	["ayu"] = {
		spec = "https://github.com/Luxed/ayu-vim",
		setup = function()
			vim.g.ayucolor = "dark"
			vim.g.ayu_italic_comment = 1
			vim.cmd([[colorscheme ayu]])
		end,
	},
	["noctis"] = {
		specs = {
			"https://github.com/rktjmp/lush.nvim",
			"https://github.com/kartikp10/noctis.nvim",
		},
		setup = function()
			vim.cmd([[colorscheme noctis]])
		end,
	},
	["fusion"] = {
		spec = "https://github.com/lfenzo/fusion.nvim",
		setup = function()
			vim.cmd([[colorscheme fusion]])
		end,
	},
	["deviuspro"] = {
		spec = "https://github.com/DeviusVim/deviuspro.nvim",
		setup = function()
			vim.cmd([[colorscheme deviuspro]])
		end,
	},
	["gruvbox"] = {
		spec = { src = "https://github.com/morhetz/gruvbox", name = "gruvbox" },
		setup = function()
			vim.g.gruvbox_contrast_dark = "hard"
			vim.g.gruvbox_contrast_light = "hard"
			vim.cmd([[colorscheme gruvbox]])
		end,
	},
	["light"] = {
		spec = { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
		setup = function()
			vim.cmd([[colorscheme catppuccin-latte]])
		end,
	},
	["brightburn"] = {
		spec = "https://github.com/erikbackman/brightburn.vim",
		setup = function()
			vim.cmd([[colorscheme brightburn]])
		end,
	},
	["kanagawa"] = {
		spec = "https://github.com/rebelot/kanagawa.nvim",
		setup = function()
			require("kanagawa").setup({})
			vim.cmd([[colorscheme kanagawa-dragon]])
		end,
	},
	["vercel"] = {
		spec = "https://github.com/ceigh/vercel-theme.nvim",
		setup = function()
			vim.cmd("colorscheme vercel")
		end,
	},
	["vesper"] = {
		spec = "https://github.com/datsfilipe/vesper.nvim",
		setup = function()
			require("vesper").setup({})
			vim.cmd("colorscheme vesper")
		end,
	},
}

local selected = themes[theme]
if not selected then
	vim.notify("Theme '" .. theme .. "' not found, using default", vim.log.levels.WARN)
	vim.o.termguicolors = false
	vim.cmd("colorscheme default")
	return {}
end

local specs = selected.specs or { selected.spec }
return {
	specs = specs,
	setup = selected.setup,
}
