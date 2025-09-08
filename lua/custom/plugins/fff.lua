return {
	"dmtrKovalenko/fff.nvim",
	build = "nix run .#release",
	lazy = false,
	opts = {
	},
	keys = {
		{
			"<leader>sf",
			function()
				require("fff").find_files()
			end,
			desc = "FFFind FFFiles",
		},
	},
}
