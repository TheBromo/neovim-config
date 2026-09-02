return {
	specs = {
		"https://github.com/folke/lazydev.nvim",
		"https://github.com/Bilal2453/luvit-meta",
		"https://github.com/neovim/nvim-lspconfig",
		"https://github.com/j-hui/fidget.nvim",
	},
	setup = function()
		require("lazydev").setup({
			library = {
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		})
		require("fidget").setup({
			notification = {
				window = {
					avoid = { "NvimTree" },
				},
			},
		})

		vim.diagnostic.config({
			severity_sort = true,
			float = { border = "single", source = "if_many" },
			underline = { severity = vim.diagnostic.severity.ERROR },
			virtual_lines = false,
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
			clangd = {},
			rust_analyzer = {},
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

			ts_ls = {},
			html = {},
			cssls = {},
			eslint = {},
			jsonls = {},
			tailwindcss = {},
			docker_language_server = {},

			nil_ls = {},
			terraformls = {},
			bashls = {},
			yamlls = {
				filetypes = { "yaml", "yaml.gitlab", "yaml.helm-values" },
				settings = {
					yaml = {
						customTags = {
							"!reference sequence",
						},
					},
				},
			},
			taplo = {},
			marksman = {},

			lua_ls = {
				settings = {
					Lua = {
						workspace = {
							userThirdParty = { os.getenv("HOME") .. "/.local/share/LuaAddons" },
							checkThirdParty = "Apply",
						},
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			},
			svls = {},
			verible = {},
		}

		for name, config in pairs(lsps) do
			vim.lsp.enable(name)
			if next(config) ~= nil then
				vim.lsp.config(name, config)
			end
		end
	end,
}
