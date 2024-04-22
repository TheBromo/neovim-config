return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },

	event = "VeryLazy",
	keys = {
		{ "<leader>-", "<cmd>Oil<cr>" },
		{ "<leader>so", "<cmd>Oil --float<cr>" },
	},

	opts = {
		float = {
			-- Padding around the floating window
			padding = 5,
		},
	},
}
