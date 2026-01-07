return {
    "ibhagwan/fzf-lua",
    event = "VimEnter",
    config = function()
        local fzf = require("fzf-lua")

        fzf.setup({ "telescope", {}
        })

        -- keymaps (mirroring your telescope setup)
        vim.keymap.set("n", "<leader>sh", fzf.help_tags, { desc = "[s]earch [h]elp" })
        vim.keymap.set("n", "<leader>sw", fzf.grep_cword, { desc = "[s]earch current [w]ord" })
        vim.keymap.set("n", "<leader>sg", fzf.live_grep_native, { desc = "[s]earch by [g]rep" })
        vim.keymap.set("n", "<leader>sd", fzf.diagnostics_document, { desc = "[s]earch [d]iagnostics" })
        vim.keymap.set("n", "<leader>sr", fzf.resume, { desc = "[s]earch [r]esume" })
        vim.keymap.set("n", "<leader>s.", fzf.oldfiles, { desc = '[s]earch recent files ("." for repeat)' })
        vim.keymap.set("n", "<leader><leader>", fzf.buffers, { desc = "[ ] find existing buffers" })

        -- Theme picker (using fzf-lua instead of telescope)
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
