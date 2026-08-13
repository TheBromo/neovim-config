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
	["catppuccin"] = {
		spec = { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
		setup = function()
			require("catppuccin").setup({
				integrations = {
					cmp = true,
					treesitter = true,
					telescope = true,
					notify = true,
					gitsigns = true,
					noice = true,
					dap = true,
					dap_ui = true,
					nvimtree = true,
					markdown = true,
					mason = true,
				},
			})

			local catppuccin = require("catppuccin.palettes.mocha")
			vim.cmd.colorscheme("catppuccin")

			vim.api.nvim_set_hl(0, "EdgyWinBar", { bg = catppuccin.mantle })
			vim.api.nvim_set_hl(0, "EdgyNormal", { bg = catppuccin.mantle })
			vim.api.nvim_set_hl(0, "LspInlayHint", { bg = catppuccin.base, fg = catppuccin.overlay0 })
			vim.api.nvim_set_hl(0, "WinSeparator", { bg = catppuccin.mantle, fg = catppuccin.surface1 })
			vim.api.nvim_set_hl(0, "TreesitterContextBottom", { sp = catppuccin.surface2, underline = false })
			vim.api.nvim_set_hl(0, "TreesitterContextLineNumberBottom", { sp = catppuccin.surface2, underline = false })
		end,
	},
	["tokyonight"] = {
		spec = "https://github.com/folke/tokyonight.nvim",
		setup = function()
			require("tokyonight").setup({
				transparent = true,
				styles = {
					sidebars = "transparent",
				},
			})
			vim.cmd("colorscheme tokyonight")
		end,
	},
	["cyberdream"] = {
		spec = "https://github.com/scottmckendry/cyberdream.nvim",
		setup = function()
			-- Compensate for the terminal renderer lifting this to roughly #1d1e20.
			local context_bg = "#17191b"

			require("cyberdream").setup({
				transparent = true,
				borderless_pickers = false,
				saturation = 0.95,
				cache = true,
				colors = {
					bg = "#080808",
					bg_solid = "#080808",
					bg_highlight = "#5b595c",
					fg = "#fcfcfa",
					grey = "#8e8d8d",
				},
			})

			vim.cmd("colorscheme cyberdream")
			vim.api.nvim_set_hl(0, "Cursor", { bg = "#c1c0c0", fg = "#8e8d8d" })
			vim.api.nvim_set_hl(0, "Visual", { bg = "#5b595c", fg = "#fcfcfa" })
			vim.api.nvim_set_hl(0, "TroubleNormal", { bg = "none", ctermbg = "none" })
			vim.api.nvim_set_hl(0, "TroubleNormalNC", { bg = "none", ctermbg = "none" })
			vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#3c4048", bg = "none" })
			vim.api.nvim_set_hl(0, "IndentBlanklineChar", { fg = "#7b8496" })
			vim.api.nvim_set_hl(0, "TreesitterContext", { bg = context_bg })
			vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { bg = context_bg })
			vim.api.nvim_set_hl(0, "TreesitterContextBottom", { bg = context_bg, underline = true })
			vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#fcfcfa" })
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
vim.list_extend(specs, { "https://github.com/xiyaowong/transparent.nvim" })
return {
	specs = specs,
	setup = function()
		selected.setup()

		local ok, transparent = pcall(require, "transparent")
		if ok then
			transparent.setup({})
		end
	end,
}
