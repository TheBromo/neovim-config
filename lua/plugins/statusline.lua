return {
	{ -- Collection of various small independent plugins/modules
		"echasnovski/mini.nvim",
		config = function()
			local statusline = require("mini.statusline")
			statusline.setup()

			statusline.section_location = function()
				return "%2l:%-2v"
			end
		end,
	},
}
