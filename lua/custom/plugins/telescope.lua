return {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { 'nvim-tree/nvim-web-devicons',            enabled = vim.g.have_nerd_font },
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
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown(),
                },
            },
        })

        -- Enable telescope extensions, if they are installed
        pcall(require("telescope").load_extension, "fzf")
        pcall(require("telescope").load_extension, "ui-select")

        -- See `:help telescope.builtin`
        local builtin = require("telescope.builtin")
        vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
        vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
        vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
        vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
        vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
        vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
        vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
        vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
        vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
        vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
        -- Slightly advanced example of overriding default behavior and theme
        vim.keymap.set("n", "<leader>/", function()
            -- You can pass additional configuration to telescope to change theme, layout, etc.
            builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
                winblend = 10,
                previewer = false,
            }))
        end, { desc = "[/] Fuzzily search in current buffer" })

        -- Also possible to pass additional configuration options.
        --  See `:help telescope.builtin.live_grep()` for information about particular keys
        vim.keymap.set("n", "<leader>s/", function()
            builtin.live_grep({
                grep_open_files = true,
                prompt_title = "Live Grep in Open Files",
            })
        end, { desc = "[S]earch [/] in Open Files" })

        local themes = {
            "monokai-pro",
            "moonfly",
            "midnight-desert",
            "ayu",
            "noctis",
            "fusion",
            "deviuspro",
            "gruvbox",
            "brightburn",
            "kanagawa"
        }

        local function select_theme()
            local actions = require('telescope.actions')
            local action_state = require('telescope.actions.state')
            local pickers = require('telescope.pickers')
            local finders = require('telescope.finders')
            local conf = require('telescope.config').values

            pickers.new({}, {
                prompt_title = "Select Theme",
                finder = finders.new_table {
                    results = themes,
                },
                sorter = conf.generic_sorter({}),
                attach_mappings = function(prompt_bufnr, map)
                    local function set_theme_and_close()
                        local selection = action_state.get_selected_entry()
                        if selection then
                            local theme = selection[1]
                            vim.fn.setenv("NVIM_THEME", theme)
                            vim.fn.writefile({ theme }, vim.fn.stdpath('config') .. '/.nvim_theme')
                            actions.close(prompt_bufnr)

                            vim.print("restart to see " .. theme .. " theme")
                        end
                    end

                    map('i', '<CR>', set_theme_and_close)
                    map('n', '<CR>', set_theme_and_close)

                    return true
                end
            }):find()
        end

        -- Add a command to call the function
        vim.api.nvim_create_user_command('Theme', select_theme, {})
    end,
}
