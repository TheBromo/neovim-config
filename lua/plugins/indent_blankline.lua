return {
	specs = { "https://github.com/lukas-reineke/indent-blankline.nvim" },
	setup = function()
		-- Some themes do not define this legacy scope highlight.
		vim.api.nvim_set_hl(0, "IndentBlanklineChar", { default = true, link = "Comment" })
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
