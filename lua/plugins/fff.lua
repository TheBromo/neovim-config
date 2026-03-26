return {
	"dmtrKovalenko/fff.nvim",
	-- build = function()
	-- 	-- this will download prebuild binary or try to use existing rustup toolchain to build from source
	-- 	-- (if you are using lazy you can use gb for rebuilding a plugin if needed)
	-- 	require("fff.download").download_or_build_binary()
	-- end,
	build = "nix run .#release",
	lazy = false,
	opts = {
		prompt = '🦖 '
	},
	keys = {
		{
			"<leader>sf",
			function()
				require("fff").find_files()
			end,
			desc = "FFFind FFFiles",
		},
		{
			"<leader>sg",
			function()
				require("fff").live_grep()
			end,
			desc = "Live grep",
		},
		{
			"<leader>sw",
			function()
				require("fff").live_grep({ query = vim.fn.expand("<cword>") })
			end,
			desc = "Search current word",
		},
		{
			"<leader>sz",
			function()
				require("fff").live_grep({
					grep = {
						modes = { "fuzzy", "plain" },
					},
				})
			end,
			desc = "Fuzzy grep",
		},
	},
}
