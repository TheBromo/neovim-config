return {
	specs = { "https://github.com/ibhagwan/fzf-lua" },
	setup = function()
		local fzf = require("fzf-lua")

		fzf.setup({ "telescope", {} })

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

		vim.ui.select = function(items, opts, on_choice)
			require("fzf-lua").fzf_exec(items, {
				prompt = (opts.prompt or "") .. "> ",
				actions = {
					["default"] = function(selected)
						if selected[1] then
							on_choice(selected[1], selected[1])
						end
					end,
				},
			})
		end
	end,
}
