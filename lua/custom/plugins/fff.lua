return {
	"dmtrKovalenko/fff.nvim",
	build = "cargo build --release",
	-- build = "nix run .#release",
	opts = {
		-- pass here all the options
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
