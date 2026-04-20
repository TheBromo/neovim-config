return {
	specs = { "https://github.com/stevearc/conform.nvim" },
	setup = function()
		require("conform").setup({
			notify_on_error = false,
			format_on_save = function(bufnr)
				local disable_filetypes = { c = true, cpp = true }
				local lsp_format_opt
				if disable_filetypes[vim.bo[bufnr].filetype] then
					lsp_format_opt = "never"
				else
					lsp_format_opt = "fallback"
				end
				return {
					timeout_ms = 500,
					lsp_format = lsp_format_opt,
				}
			end,
			formatters_by_ft = {
				nix = { "nixfmt" },
				lua = { "stylua" },
				python = { "ruff" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				go = { "gofmt" },
			},
		})

		vim.keymap.set("", "<leader>f", function()
			require("conform").format({ async = true, lsp_format = "fallback" })
		end, { desc = "[F]ormat buffer" })
	end,
}
