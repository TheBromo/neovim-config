local base_dir = vim.env.NVIM_BASE_DIR
    or (function()
        local init_path = debug.getinfo(1, "S").source
        return init_path:sub(2):match("(.*[/\\])"):sub(1, -2)
    end)()

if not vim.tbl_contains(vim.opt.rtp:get(), base_dir) then
    vim.opt.rtp:prepend(base_dir)
end


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

require("custom.options")
require("custom.mappings")

lazy.setup({
        { 'tpope/vim-sleuth' },
        require("custom.plugins.telescope"),
        require("custom.plugins.mason"),
        require("custom.plugins.completions"),

        require("custom.plugins.colorscheme"),
        require("custom.plugins.mini"),
        require("custom.plugins.treesitter"),

        require("custom.plugins.oil"),
        require("custom.plugins.lualine"),
        require("custom.plugins.debugging"),
        require("custom.plugins.tmux"),
        require("custom.plugins.harpoon"),
        require("custom.plugins.undotree"),
        require("custom.plugins.obsidian"),
    },
    {
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
