return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	main = "nvim-treesitter.configs",

	build = ":TSUpdate",

	opts = {
		ensure_installed = { "bash", "c", "html", "lua", "markdown", "vim", "vimdoc" },
		ignore_install = {},

		sync_install = false,
		auto_install = true,
		highlight = {
			enable = true,
			disable = function(_, buf)
				return require("custom.utils.file").is_large_buffer(buf)
			end,
		},

		indent = {
			enable = true,
			disable = function(_, buf)
				return require("custom.utils.file").is_large_buffer(buf)
			end,
		},
	},
}
