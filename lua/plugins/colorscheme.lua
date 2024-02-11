return {
	"ramojus/mellifluous.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		vim.opt.termguicolors = true
		require 'mellifluous'.setup({
			color_set = 'mountain',
		})
		vim.cmd.colorscheme("mellifluous")
	end,
}
