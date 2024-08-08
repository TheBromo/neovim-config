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
        { 'tpope/vim-sleuth' }, -- Detect tabstop and shiftwidth automatically

        -- Decorations
        require("custom.plugins.git"),
        { -- Useful plugin to show you pending keybinds.
            'folke/which-key.nvim',
            event = 'VimEnter', -- Sets the loading event to 'VimEnter'
            config = function() -- This is the function that runs, AFTER loading
              require('which-key').setup()

              -- Document existing key chains
              require('which-key').add {
                { '<leader>c', group = '[C]ode' },
                { '<leader>d', group = '[D]ocument' },
                { '<leader>r', group = '[R]ename' },
                { '<leader>s', group = '[S]earch' },
                { '<leader>w', group = '[W]orkspace' },
                { '<leader>t', group = '[T]oggle' },
                { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
              }
            end,
        },

        require("custom.plugins.telescope"),
        require("custom.plugins.mason"),
        require("custom.plugins.autoformat"),
         require("custom.plugins.completions"),

        require("custom.plugins.colorscheme"),
        { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
        require("custom.plugins.mini"),
        require("custom.plugins.treesitter"),

        require("custom.plugins.oil"),
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
