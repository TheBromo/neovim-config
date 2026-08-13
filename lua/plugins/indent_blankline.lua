return {
	specs = { "https://github.com/lukas-reineke/indent-blankline.nvim" },
	setup = function()
		require("ibl").setup({
			indent = {
				highlight = {
					"WhiteSpace",
				},
				char = "┊",
				tab_char = "┊",
			},
			scope = {
				show_start = false,
				show_end = false,
				char = "│",
				highlight = {
					"IndentBlanklineChar",
				},
				include = {
					node_type = {
						hcl = { "body", "block" },
						terraform = { "body", "block" },
					},
				},
			},
		})
	end,
}
