return {
    {
        "loctvl842/monokai-pro.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("monokai-pro").setup({
                terminal_colors = true,
                filter = "pro",


                background_clear = {
                    "float_win",
                    "telescope",
                },
                overrideScheme = function(cs, p, config, hp)
                    local cs_override = {}
                    cs_override.editor = {
                        background = "#080808",
                    }

                    return cs_override
                end
            })
            vim.cmd([[colorscheme monokai-pro]])
        end
    },
    {
        "bluz71/vim-moonfly-colors",
        name = "moonfly",
        event = "VeryLazy",
        config = function()
            vim.g.moonflyWinSeparator = 2
            vim.g.moonflyNormalFloat = true
        end,
    },
    {
        "CosecSecCot/midnight-desert.nvim",
        event = "VeryLazy",
        dependencies = {
            "rktjmp/lush.nvim",
        },
    },
    {
        'Shatur/neovim-ayu',
        event = "VeryLazy",
        config = function()
            require('ayu').setup({
                mirage = false,  -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
                terminal = true, -- Set to `false` to let terminal manage its own colors.
                overrides = {},  -- A dictionary of group names, each associated with a dictionary of parameters (`bg`, `fg`, `sp` and `style`) and colors in hex.
            })
        end,
    },
    {
        'kartikp10/noctis.nvim',

        event = "VeryLazy",
        dependencies = { 'rktjmp/lush.nvim' }
    },
    {
        "lfenzo/fusion.nvim",
        event = "VeryLazy",
    },
    {
        "DeviusVim/deviuspro.nvim",
        event = "VeryLazy",
    },
    {
        "ellisonleao/gruvbox.nvim",
        event = "VeryLazy",
        name = "gruvbox",
        config = function()
            require("gruvbox").setup({
                terminal_colors = true, -- add neovim terminal colors
                contrast = "",          -- can be "hard", "soft" or empty string
            })
        end,
    },
    {
        "erikbackman/brightburn.vim",
        event = "VeryLazy",
    },
    {
        "rebelot/kanagawa.nvim",
        event = "VeryLazy",
        config = function()
            require('kanagawa').setup({});
        end
    }
}
