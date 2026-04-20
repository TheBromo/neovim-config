return {
	specs = {
		"https://github.com/windwp/nvim-autopairs",
		"https://github.com/hrsh7th/nvim-cmp",
		"https://github.com/windwp/nvim-ts-autotag",
	},
	setup = function()
		require("nvim-autopairs").setup({})
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		local cmp = require("cmp")

		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

		require("nvim-ts-autotag").setup({
			opts = {
				enable_close = true,
				enable_rename = true,
				enable_close_on_slash = false,
			},
		})
	end,
}
