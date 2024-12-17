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
                    devicons = false,
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
        "MinhCreator/base46.nvim",
        lazy = false,

        config = function()
            local present, base46 = pcall(require, "base46")
            if not present then
                return
            end

            local t = "mountain"
            local theme_opts = {
                theme = t,
            }

            base46.load_theme(theme_opts)
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
elseif theme == "sonokai-pro" then
    return {
        'sainnhe/sonokai',
        lazy = false,
        priority = 1000,

        config = function()
            local background = "#121212"
            local highlight = "#353535"

            vim.g.sonokai_enable_italic = true
            vim.g.sonokai_style = "default"
            vim.g.sonokai_better_performance = 1
            vim.g.sonokai_enable_italic = 1

            vim.g.sonokai_transparent_background = 1
            vim.g.sonokai_diagnostic_virtual_text = "colored"

            vim.cmd.colorscheme('sonokai')
            -- Set overrides
            local hl = function(group, opts)
                vim.api.nvim_set_hl(0, group, opts)
            end

            hl("@text.note", {
                bold = true,
                standout = true,
            })
            hl("WinSeparator", {

                fg = highlight,
            })
            hl("QuickScopePrimary", {
                bold = true,
                bg = "#6dcccc",
                fg = background,
            })
            hl("QuickScopeSecondary", {
                bold = true,
                bg = "#888888",
                fg = background,
            })
            hl("SignColumn", {
                bg = "None",
            })
            hl("IndentBlankLineChar", {
                fg = highlight,
                nocombine = true,
            })
            hl("IndentBlankLineContextChar", {
                fg = "#888888",
                nocombine = true,
            })
            hl("IndentBlankLineSpaceChar", {
                fg = highlight,
                nocombine = true,
            })
        end
    }
else
    return {}
end
