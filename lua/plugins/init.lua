return {
	"tpope/vim-sleuth",
	{ "numToStr/Comment.nvim", opts = {} },
	-- Decorations
	require("plugins.colorscheme"),
	require("plugins.statusline"),

	-- Code intel
	require("plugins.treesitter"),
	require("plugins.lsp"),
	require("plugins.autoformat"),
	require("plugins.completions"),

	-- Highlight todo, notes, etc in comments
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},

	require("plugins.telescope"),
	require("plugins.git"),
	require("plugins.oil"),
	require("plugins.tmux"),

	require("plugins.harpoon"),
	require("plugins.undotree"),
	require("plugins.obsidian"),
}
