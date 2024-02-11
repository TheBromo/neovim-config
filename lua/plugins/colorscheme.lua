return {
	"ramojus/mellifluous.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		vim.opt.termguicolors = true
		require 'mellifluous'.setup({})
		vim.cmd.colorscheme("mellifluous")
	end,
}
