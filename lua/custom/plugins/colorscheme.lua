local theme_file = vim.fn.stdpath('config') .. '/.nvim_theme'
local theme = 'monokai-pro'
if vim.fn.filereadable(theme_file) == 1 then
    theme = vim.fn.readfile(theme_file)[1]
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
                    devicons = false, -- vim.g.have_nerd_font,
                    background_clear = {
                        "float_win",
                        "telescope",
                    },

                    overridePalette = function(_)
                        return {
                            dark1 = "#121212",
                            background = "#080808",
                        }
                    end
                })
                vim.cmd([[colorscheme monokai-pro]])
            end
        }
    }
elseif theme == "nightlamp" then
    return {
        "MinhCreator/base46.nvim",
        lazy = false,

        config = function()
            local present, base46 = pcall(require, "base46")
            if not present then
                return
            end

            local t = "nightlamp"

            local theme_opts = {
                theme = t,
            }

            base46.load_theme(theme_opts)
        end,
    }
elseif theme == "mountain" then
    return {
        "mountain-theme/vim",
        lazy = false,
        config = function()
            vim.cmd([[colorscheme mountain]])
        end,
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
                vim.g.ayucolor = "dark"
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
            "morhetz/gruvbox",
            name = "gruvbox",
            lazy = false,
            priority = 1000,
            config = function()
                vim.g.gruvbox_contrast_dark = "hard"
                vim.g.gruvbox_contrast_light = "hard"
                vim.cmd([[colorscheme gruvbox]])
            end,
        }
    }
elseif theme == "light" then
    return {
        {
            "catppuccin/nvim",
            name = "catppuccin",
            priority = 1000,
            config = function()
                vim.cmd([[colorscheme catppuccin-latte]])
            end
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
elseif theme == "vercel" then
    return {
        "https://github.com/ceigh/vercel-theme.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd("colorscheme vercel")
        end,
    }
elseif theme == "none" then
    return {}
end
