return {
	"stevearc/oil.nvim",

	event = "VeryLazy",

	config = function()
		require("oil").setup()
		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
	end,

	opts = {
		view_options = {
			show_hidden = true,
		},
	},
}
