require("custom.options")
require("custom.mappings")

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
	{ "tpope/vim-sleuth" },
	require("custom.plugins.telescope"),
	require("custom.plugins.lsp"),
	require("custom.plugins.completions"),
	require("custom.plugins.autoformat"),

	require("custom.plugins.colorscheme"),
	require("custom.plugins.treesitter"),
	require("custom.plugins.autopairs"),

	require("custom.plugins.mini"),
	require("custom.plugins.nvimtree"),
	require("custom.plugins.oil"),
	require("custom.plugins.debugging"),
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
