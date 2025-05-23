return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },

	keys = {
		{
			"<leader>a",
			function()
				require("harpoon"):list():add()
			end,
			desc = "[A]dd to harpoon",
		},
		{
			"<C-e>",
			function()
				local harpoon = require("harpoon")
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end,
			desc = "Harpoon [E]xplorer",
		},

		{
			"1",
			function()
				require("harpoon"):list():select(1)
			end,
		},
		{
			"2",
			function()
				require("harpoon"):list():select(2)
			end,
		},
		{
			"3",
			function()
				require("harpoon"):list():select(3)
			end,
		},
		{
			"4",
			function()
				require("harpoon"):list():select(4)
			end,
		},
	},

	opts = {},
}
