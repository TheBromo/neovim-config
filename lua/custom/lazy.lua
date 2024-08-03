local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    -- clone lazy if not already exists
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
    return
end

lazy.setup({
        -- Decorations
        require("custom.plugins.git"),
        require("custom.plugins.colorscheme"),
        require("custom.plugins.statusline"),
        require("custom.plugins.mini"),

        -- Code intel
        require("custom.plugins.treesitter"),
        require("custom.plugins.lsp"),
        require("custom.plugins.autoformat"),

        require("custom.plugins.completions"),

        -- Highlight todo, notes, etc in comments
        {
            "folke/todo-comments.nvim",
            event = { "BufRead", "BufWinEnter", "BufNewFile" },
            dependencies = { "nvim-lua/plenary.nvim" },
            opts = { signs = false },
        },

        require("custom.plugins.telescope"),
        require("custom.plugins.oil"),
        require("custom.plugins.tmux"),

        require("custom.plugins.harpoon"),
        require("custom.plugins.undotree"),
        require("custom.plugins.obsidian"),

    },
    {
        defaults = { lazy = true },
        ui = {
            icons = vim.g.have_nerd_font and {} or {
                cmd = "⌘",
                config = "🛠",
                event = "📅",
                ft = "📂",
                init = "⚙",
                keys = "🗝",
                plugin = "🔌",
                runtime = "💻",
                require = "🌙",
                source = "📄",
                start = "🚀",
                task = "📌",
                lazy = "💤 ",
            },
        },
    })
