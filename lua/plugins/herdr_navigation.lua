return {
	specs = {
		{
			src = "https://github.com/aimdevlee/herdr-nvim-nav",
			version = "v1.0.0",
		},
	},
	setup = function()
		require("herdr-nvim-nav").setup({
			with_tmux = false,
			keymaps = {
				left = { "<C-h>" },
				down = { "<C-j>" },
				up = { "<C-k>" },
				right = { "<C-l>" },
			},
		})
	end,
}
