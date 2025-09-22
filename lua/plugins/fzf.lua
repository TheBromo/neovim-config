return {
    "ibhagwan/fzf-lua",
    event = "VimEnter",
    config = function()
        local fzf = require("fzf-lua")

        fzf.setup({
            fzf_opts = {
                ["--layout"] = "default", -- this flips the order so prompt is at bottom
            },
            winopts = {
                border = "single",
                preview = {
                    layout = "horizontal", -- or "horizontal", "flex"
                },
            },
            files = {
                -- ignore patterns similar to telescope’s
                fd_opts =
                [[--color=never --type f --hidden --follow --exclude .git --exclude node_modules --exclude build]],
            },
        })

        -- keymaps (mirroring your telescope setup)
        vim.keymap.set("n", "<leader>sh", fzf.help_tags, { desc = "[s]earch [h]elp" })
        vim.keymap.set("n", "<leader>sw", fzf.grep_cword, { desc = "[s]earch current [w]ord" })
        vim.keymap.set("n", "<leader>sg", fzf.live_grep, { desc = "[s]earch by [g]rep" })
        vim.keymap.set("n", "<leader>sd", fzf.diagnostics_document, { desc = "[s]earch [d]iagnostics" })
        vim.keymap.set("n", "<leader>sr", fzf.resume, { desc = "[s]earch [r]esume" })
        vim.keymap.set("n", "<leader>s.", fzf.oldfiles, { desc = '[s]earch recent files ("." for repeat)' })
        vim.keymap.set("n", "<leader><leader>", fzf.buffers, { desc = "[ ] find existing buffers" })

        -- Theme picker (using fzf-lua instead of telescope)
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
            fzf.fzf_exec(themes, {
                prompt = "select theme> ",
                actions = {
                    ["default"] = function(selected)
                        local theme = selected[1]
                        if theme then
                            vim.fn.writefile({ theme }, vim.fn.stdpath("config") .. "/.nvim_theme")
                            vim.notify("restart to see " .. theme .. " theme", vim.log.levels.INFO)
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
