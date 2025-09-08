local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("options")
require("mappings")
require("autocommands")

require("lazy").setup({
	{
		"NMAC427/guess-indent.nvim",
		lazy = false,
		config = function()
			require("guess-indent").setup({})
		end,
	},

	require("plugins.fzf"),
	require("plugins.fff"),

	require("plugins.lsp"),
	require("plugins.completions"),
	require("plugins.autoformat"),
	require("plugins.autopairs"),

	require("plugins.colorscheme"),
	require("plugins.gitsigns"),

	require("plugins.mini"),
	require("plugins.nvimtree"),
	require("plugins.oil"),
	require("plugins.tmux"),

	require("plugins.undotree"),
	require("plugins.obsidian"),
	require("plugins.treesitter"),
}, {
	defaults = { lazy = true, },
	performance = {
		rtp = {
			reset = false,
		},
	},
	ui = {
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})
