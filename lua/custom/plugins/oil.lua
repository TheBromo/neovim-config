return {
	"stevearc/oil.nvim",

	event = "VeryLazy",

	config = function()
		require("oil").setup({
			default_file_explorer = true,
			skip_confirm_for_simple_edits = true,
			view_options = {
				show_hidden = true,
				is_hidden_file = function(name, _)
					return vim.startswith(name, ".")
				end,
			},
		})
		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
	end,
}
