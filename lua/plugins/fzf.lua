return {
	specs = { "https://github.com/ibhagwan/fzf-lua" },
	setup = function()
		local fzf = require("fzf-lua")
		local search_ignore_patterns = { "%.devenv/", "%.direnv/", "node_modules/" }

		fzf.setup({
			"telescope",
			files = {
				fd_opts = "--color=never --type f --type l --exclude .git --exclude .jj --exclude .devenv --exclude .direnv --exclude node_modules",
				file_ignore_patterns = search_ignore_patterns,
			},
			grep = { file_ignore_patterns = search_ignore_patterns },
			lsp = { file_ignore_patterns = search_ignore_patterns },
			oldfiles = { file_ignore_patterns = search_ignore_patterns },
		})
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
