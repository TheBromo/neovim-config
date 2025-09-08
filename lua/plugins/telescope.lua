return {
	"nvim-telescope/telescope.nvim",
	event = "vimenter",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",

			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },
	},
	config = function()
		require("telescope").setup({
			defaults = {
				borderchars = {
					prompt = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
					results = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
					preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
				},
				file_ignore_patterns = {
					"node_modules",
					".git",
					"build",
				},
				-- other configuration options
			},

			extensions = {
				fzf = {},
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})

		-- enable telescope extensions, if they are installed
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")

		-- see `:help telescope.builtin`
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[s]earch [h]elp" })
		-- vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[s]earch [f]iles" })
		vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[s]earch current [w]ord" })
		vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[s]earch by [g]rep" })
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[s]earch [d]iagnostics" })
		vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[s]earch [r]esume" })
		vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[s]earch recent files ("." for repeat)' })
		vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] find existing buffers" })

		-- slightly advanced example of overriding default behavior and theme
		vim.keymap.set("n", "<leader>/", function()
			-- you can pass additional configuration to telescope to change theme, layout, etc.
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, { desc = "[/] fuzzily search in current buffer" })

		-- also possible to pass additional configuration options.
		--  see `:help telescope.builtin.live_grep()` for information about particular keys
		vim.keymap.set("n", "<leader>s/", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "live grep in open files",
			})
		end, { desc = "[s]earch [/] in open files" })

		local themes = {
			"monokai-pro",
			"mountain",
			"nightlamp",
			"sonokai-pro",
			"moonfly",
			"midnight-desert",
			"ayu",
			"noctis",
			"fusion",
			"deviuspro",
			"gruvbox",
			"brightburn",
			"kanagawa",
			"light",
			"vercel",
			"vesper",
			"none",
		}

		local function select_theme()
			local actions = require("telescope.actions")
			local action_state = require("telescope.actions.state")
			local pickers = require("telescope.pickers")
			local finders = require("telescope.finders")
			local conf = require("telescope.config").values

			pickers
				.new({}, {
					prompt_title = "select theme",
					finder = finders.new_table({
						results = themes,
					}),
					sorter = conf.generic_sorter({}),
					attach_mappings = function(prompt_bufnr, map)
						local function set_theme_and_close()
							local selection = action_state.get_selected_entry()
							if selection then
								local theme = selection[1]
								vim.fn.writefile({ theme }, vim.fn.stdpath("config") .. "/.nvim_theme")
								actions.close(prompt_bufnr)

								vim.print("restart to see " .. theme .. " theme")
							end
						end

						map("i", "<cr>", set_theme_and_close)
						map("n", "<cr>", set_theme_and_close)

						return true
					end,
				})
				:find()
		end
		vim.api.nvim_create_user_command("theme", select_theme, {})
	end,
}
