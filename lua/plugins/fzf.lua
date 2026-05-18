return {
	specs = { "https://github.com/ibhagwan/fzf-lua" },
	setup = function()
		local fzf = require("fzf-lua")

		fzf.setup({ "telescope", {} })
		fzf.register_ui_select(nil, true)

		vim.keymap.set("n", "<leader>sh", fzf.help_tags, { desc = "[s]earch [h]elp" })
		vim.keymap.set("n", "<leader>sd", fzf.diagnostics_document, { desc = "[s]earch [d]iagnostics" })

		local theme_utils = require("theme_utils")

		local function select_theme()
			fzf.fzf_exec(theme_utils.themes, {
				prompt = "select theme> ",
				actions = {
					["default"] = function(selected)
						local theme = selected[1]
						if theme then
							theme_utils.save_theme(theme)
						end
					end,
				},
			})
		end
		vim.api.nvim_create_user_command("Theme", select_theme, {})

	end,
}
