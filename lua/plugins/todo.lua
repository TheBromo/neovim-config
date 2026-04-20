return {
	specs = {
		"https://github.com/nvim-lua/plenary.nvim",
		"https://github.com/folke/todo-comments.nvim",
	},
	setup = function()
		require("todo-comments").setup({})
	end,
}
