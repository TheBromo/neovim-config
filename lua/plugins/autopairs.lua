return {
	specs = {
		"https://github.com/windwp/nvim-autopairs",
		"https://github.com/windwp/nvim-ts-autotag",
	},
	setup = function()
		require("nvim-autopairs").setup({})

		require("nvim-ts-autotag").setup({
			opts = {
				enable_close = true,
				enable_rename = true,
				enable_close_on_slash = false,
			},
		})
	end,
}
