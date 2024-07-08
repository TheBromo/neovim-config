return {
	"tpope/vim-sleuth",
	-- Decorations
	require("plugins.git"),
	require("plugins.colorscheme"),
	require("plugins.statusline"),
	require("plugins.mini"),

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
	require("plugins.oil"),
	require("plugins.tmux"),

	require("plugins.harpoon"),
	require("plugins.undotree"),
	require("plugins.obsidian"),
}
