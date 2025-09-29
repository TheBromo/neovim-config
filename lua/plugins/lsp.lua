return {
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true },
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "j-hui/fidget.nvim", opts = {} },
			"saghen/blink.cmp",
		},
		config = function()
			vim.diagnostic.config({
				severity_sort = true,
				float = { border = "single", source = "if_many" },
				underline = { severity = vim.diagnostic.severity.ERROR },
				virtual_lines = true,
				virtual_text = {
					source = "if_many",
					spacing = 2,
					format = function(diagnostic)
						local diagnostic_message = {
							[vim.diagnostic.severity.ERROR] = diagnostic.message,
							[vim.diagnostic.severity.WARN] = diagnostic.message,
							[vim.diagnostic.severity.INFO] = diagnostic.message,
							[vim.diagnostic.severity.HINT] = diagnostic.message,
						}
						return diagnostic_message[diagnostic.severity]
					end,
				},
			})
			local lsps = {
				clangd = {

				},
				gopls = {
					settings = {
						gopls = {
							hints = {
								functionTypeParameters = true,
								parameterNames = true,
							},
						},
					},
				},
				ty = {},
				basedpyright = {},
				ts_ls = {},
				terraformls = {},
				html = {},
				cssls = {},
				eslint = {},
				yamlls = {
					filetypes = { "yml", "yaml", "yaml.docker-compose", "yaml.gitlab", "yaml.helm-values" }
				},
				jsonls = {},
				tailwindcss = {},
				nixd = {},
				lua_ls = {
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				},
			}

			for name, config in pairs(lsps) do
				vim.lsp.enable(name)
				if next(config) ~= nil then
					vim.lsp.config(name, config)
				end
			end
		end,
	},
}
