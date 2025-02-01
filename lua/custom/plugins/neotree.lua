return {

	"nvim-neo-tree/neo-tree.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	cmd = "Neotree",
	keys = {
		{ "\\", ":Neotree position=right reveal<CR>", desc = "NeoTree reveal", silent = true },
	},
	config = function()
		require("neo-tree").setup({
			default_component_configs = {
				icon = {
					folder_closed = "▶",
					folder_open = "▼",
					folder_empty = "▷",
					provider = function(icon, node)
						local text, hl
						local mini_icons = require("mini.icons")
						if node.type == "file" then
							text, hl = mini_icons.get("file", node.name)
						elseif node.type == "directory" then
							text, hl = mini_icons.get("directory", node.name)
							if node:is_expanded() then
								text = nil
							end
						end

						if text then
							icon.text = text
						end
						if hl then
							icon.highlight = hl
						end
					end,
					kind_icon = {
						provider = function(icon, node)
							icon.text, icon.highlight = require("mini.icons").get("lsp", node.extra.kind.name)
						end,
					},
					git_status = {
						symbols = {
							-- Change type
							deleted = "(x)", -- this can only be used in the git_status source
							renamed = "(r)", -- this can only be used in the git_status source
							-- Status type
							untracked = "(u)",
							ignored = "(i)",
							unstaged = "",
							staged = "",
							conflict = "(▒)",
						},
					},
				},
			},
			filesystem = {
				follow_current_file = {
					enabled = true,
				},
				window = {
					mappings = {
						["\\"] = "close_window",
					},
				},
				filtered_items = {
					visible = true, -- when true, they will just be displayed differently than normal items
				},
			},
		})
	end,
}
