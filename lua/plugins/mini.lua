return {
	specs = { "https://github.com/nvim-mini/mini.nvim" },
	setup = function()
		require("mini.ai").setup({ n_lines = 500 })

		require("mini.surround").setup()

		require("mini.icons").setup({
			style = "ascii",
		})
		MiniIcons.mock_nvim_web_devicons()
		MiniIcons.tweak_lsp_kind("replace")

		local miniclue = require("mini.clue")
		miniclue.setup({
			triggers = {
				{ mode = "n", keys = "<Leader>" },
				{ mode = "x", keys = "<Leader>" },

				{ mode = "i", keys = "<C-x>" },

				{ mode = "n", keys = "g" },
				{ mode = "x", keys = "g" },

				{ mode = "n", keys = "'" },
				{ mode = "n", keys = "`" },
				{ mode = "x", keys = "'" },
				{ mode = "x", keys = "`" },

				{ mode = "n", keys = '"' },
				{ mode = "x", keys = '"' },

				{ mode = "i", keys = "<C-r>" },
				{ mode = "c", keys = "<C-r>" },

				{ mode = "n", keys = "<C-w>" },

				{ mode = "n", keys = "z" },
				{ mode = "x", keys = "z" },
			},

			clues = {
				{ mode = "n", keys = "<Leader>c", desc = "[C]ode" },
				{ mode = "n", keys = "<Leader>d", desc = "[D]ocument" },
				{ mode = "n", keys = "<Leader>r", desc = "[R]ename" },
				{ mode = "n", keys = "<Leader>s", desc = "[S]earch" },
				{ mode = "n", keys = "<Leader>w", desc = "[W]orkspace" },
				{ mode = "n", keys = "<Leader>b", desc = "[B]reakpoint" },
				{ mode = "n", keys = "<Leader>t", desc = "[T]oggle" },
				{ mode = "n", keys = "<Leader>n", desc = "[N]otes" },

				miniclue.gen_clues.builtin_completion(),
				miniclue.gen_clues.g(),
				miniclue.gen_clues.marks(),
				miniclue.gen_clues.registers(),
				miniclue.gen_clues.windows(),
				miniclue.gen_clues.z(),
			},
			window = {
				delay = 0,
				config = {
					width = "auto",
				},
			},
		})

		local statusline = require("mini.statusline")
		statusline.setup({ use_icons = false })

		---@diagnostic disable-next-line: duplicate-set-field
		statusline.section_location = function()
			return "%2l:%-2v"
		end
	end,
}
