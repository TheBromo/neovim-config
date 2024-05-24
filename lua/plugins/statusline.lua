return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = {
			options = {
				theme = "moonfly",
				section_separators = "",
				component_separators = "",
				icons_enabled = false,
			},
		},
	},
	-- { -- Collection of various small independent plugins/modules
	-- 	"echasnovski/mini.nvim",
	-- 	config = function()
	-- 		local statusline = require("mini.statusline")
	-- 		statusline.setup({
	-- 			use_icons = false,
	-- 		})
	--
	-- 		statusline.section_location = function()
	-- 			return "%2l:%-2v"
	-- 		end
	-- 	end,
	-- },
}
