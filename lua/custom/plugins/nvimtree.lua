return {
    "nvim-tree/nvim-tree.lua",
    lazy = true,
    config = function()
        require("nvim-tree").setup({
            update_focused_file = {
                enable = true,
            },
            renderer = {
                indent_markers = { enable = true, },
                icons = {
                    show = {
                        file = vim.g.have_nerd_font,
                        folder = false,
                    },
                    web_devicons = {
                        file = {
                            enable = vim.g.have_nerd_font,
                            color = true,
                        },
                        folder = {
                            enable = false,
                            color = false,
                        },
                    },
                },
                decorators = { "Open", "Hidden", "Modified", "Copied", "Cut", },
            },
            view = {
                side = 'right',
            },

        })

        vim.api.nvim_create_autocmd("QuitPre", {
            callback = function()
                local tree_wins = {}
                local floating_wins = {}
                local wins = vim.api.nvim_list_wins()

                for _, w in ipairs(wins) do
                    local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
                    if bufname:match("NvimTree_") ~= nil then
                        table.insert(tree_wins, w)
                    end
                    if vim.api.nvim_win_get_config(w).relative ~= '' then
                        table.insert(floating_wins, w)
                    end
                end
                if 1 == #wins - #floating_wins - #tree_wins then
                    -- Should quit, so we close all invalid windows.
                    for _, w in ipairs(tree_wins) do
                        vim.api.nvim_win_close(w, true)
                    end
                end
            end
        })
    end
}
