return {
	specs = { "https://github.com/NMAC427/guess-indent.nvim" },
	setup = function()
		require("guess-indent").setup({
			-- Keep the JS/TS defaults even when a file already contains tabs.
			filetype_exclude = {
				"netrw",
				"tutor",
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
			},
		})
	end,
}
