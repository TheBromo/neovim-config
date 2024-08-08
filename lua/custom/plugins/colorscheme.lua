local theme_file = vim.fn.stdpath('config') .. '/.nvim_theme'
local theme = 'monokai-pro'
if vim.fn.filereadable(theme_file) == 1 then
    theme = vim.fn.readfile(theme_file)[1]
    vim.print(theme)
    vim.fn.setenv("NVIM_THEME", theme)
end


if theme == "monokai-pro" then
    return {
        {
            "loctvl842/monokai-pro.nvim",
            lazy = false,
            priority = 1000,
            config = function()
                require("monokai-pro").setup({
                    terminal_colors = true,
                    filter = "pro",
                    devicons = true,
                    background_clear = {
                        "float_win",
                        "telescope",
                    },
                    overrideScheme = function(_, _, _, _)
                        local cs_override = {}
                        cs_override.editor = {
                            background = "#080808",
                        }
                        return cs_override
                    end
                })
                vim.cmd([[colorscheme monokai-pro]])
            end
        }
    }
elseif theme == "moonfly" then
    return {
        {
            "bluz71/vim-moonfly-colors",
            name = "moonfly",
            lazy = false,
            priority = 1000,
            config = function()
                vim.g.moonflyWinSeparator = 2
                vim.g.moonflyNormalFloat = true
                vim.cmd([[colorscheme moonfly]])
            end,
        }
    }
elseif theme == "midnight-desert" then
    return {
        {
            "CosecSecCot/midnight-desert.nvim",
            dependencies = {
                "rktjmp/lush.nvim",
            },
            lazy = false,
            priority = 1000,
            config = function()
                vim.cmd([[colorscheme midnight-desert]])
            end
        }
    }
elseif theme == "ayu" then
    return {
        {
            'Luxed/ayu-vim',
            lazy = false,
            priority = 1000,
            config = function()
                vim.g.ayucolor="dark"
                vim.g.ayu_italic_comment = 1

                vim.cmd([[colorscheme ayu]])
            end,
        }
    }
elseif theme == "noctis" then
    return {
        {
            'kartikp10/noctis.nvim',
            lazy = false,
            priority = 1000,
            dependencies = { 'rktjmp/lush.nvim' },
            config = function()
                vim.cmd([[colorscheme noctis]])
            end
        }
    }
elseif theme == "fusion" then
    return {
        {
            "lfenzo/fusion.nvim",
            lazy = false,
            priority = 1000,
            config = function()
                vim.cmd([[colorscheme fusion]])
            end
        }
    }
elseif theme == "deviuspro" then
    return {
        {
            "DeviusVim/deviuspro.nvim",
            lazy = false,
            priority = 1000,
            config = function()
                vim.cmd([[colorscheme deviuspro]])
            end
        }
    }
elseif theme == "gruvbox" then
    return {
        {
            "ellisonleao/gruvbox.nvim",
            name = "gruvbox",
            lazy = false,
            priority = 1000,
            config = function()
                require("gruvbox").setup({
                    terminal_colors = true,
                    contrast = "hard",
                })
                vim.cmd([[colorscheme gruvbox]])
            end,
        }
    }
elseif theme == "brightburn" then
    return {
        {
            "erikbackman/brightburn.vim",
            lazy = false,
            priority = 1000,
            config = function()
                vim.cmd([[colorscheme brightburn]])
            end

        }
    }
elseif theme == "kanagawa" then
    return {
        {
            "rebelot/kanagawa.nvim",
            lazy = false,
            priority = 1000,
            config = function()
                require('kanagawa').setup({})


                vim.cmd([[colorscheme kanagawa-dragon]])
            end
        }
    }
else
    return {}
end
