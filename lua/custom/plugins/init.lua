return {
	-- Decorations
	require("custom.plugins.git"),
	require("custom.plugins.colorscheme"),
	require("custom.plugins.statusline"),
	require("custom.plugins.mini"),

	-- Code intel
	require("custom.plugins.treesitter"),
	require("custom.plugins.lsp"),
	require("custom.plugins.autoformat"),
	require("custom.plugins.completions"),

	-- Highlight todo, notes, etc in comments
	{
		"folke/todo-comments.nvim",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},

	require("custom.plugins.telescope"),
	require("custom.plugins.oil"),
	require("custom.plugins.tmux"),

	require("custom.plugins.harpoon"),
	require("custom.plugins.undotree"),
	require("custom.plugins.obsidian"),
}
