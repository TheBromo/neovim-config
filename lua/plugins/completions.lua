return {
	specs = {
		{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1") },
		"https://github.com/rafamadriz/friendly-snippets",
	},
	setup = function()
		require("blink.cmp").setup({
			keymap = { preset = "default" },

			appearance = {
				nerd_font_variant = "mono",
			},

			completion = {
				menu = {
					draw = {
						components = {
							kind_icon = {
								text = function(ctx)
									local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
									return kind_icon
								end,
								highlight = function(ctx)
									local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
									return hl
								end,
							},
							kind = {
								highlight = function(ctx)
									local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
									return hl
								end,
							},
						},
					},
				},
				documentation = { auto_show = true, auto_show_delay_ms = 2000 },
			},

			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},

			fuzzy = { implementation = "prefer_rust_with_warning" },
		})
	end,
}
