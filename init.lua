require("custom.options")
require("custom.mappings")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ "tpope/vim-sleuth" },
	require("custom.plugins.telescope"),
	require("custom.plugins.treesitter"),
	require("custom.plugins.lsp"),
	require("custom.plugins.completions"),
	require("custom.plugins.autoformat"),
	--
	require("custom.plugins.colorscheme"),
	require("custom.plugins.autopairs"),
	--
	require("custom.plugins.mini"),
	require("custom.plugins.nvimtree"),
	require("custom.plugins.oil"),
	require("custom.plugins.tmux"),
	require("custom.plugins.harpoon"),
	require("custom.plugins.undotree"),
	require("custom.plugins.obsidian"),
}, {
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
