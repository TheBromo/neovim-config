return {


    {
        "williamboman/mason-lspconfig.nvim",
        cmd = { "LspInstall", "LspUninstall" },
        config = function()
            require("mason-lspconfig").setup({
                automatic_installation = {
                    exclude = {}
                },
                ensure_installed = {}
            })

            -- automatic_installation is handled by lsp-manager
            local settings = require "mason-lspconfig.settings"
            settings.current.automatic_installation = false
        end,
        lazy = true,
        event = "User FileOpened",
        dependencies = "mason.nvim",
    },
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
                PATH = "append",
                --TODO: replace to dynamically load     install_root_dir = join_paths(vim.fn.stdpath "data", "mason"),
                install_root_dir = "/home/manuel/.local/share/lvim/mason",
                pip = {
                    install_args = {},
                    upgrade_pip = false
                },
            })
        end,
        cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
        build = function()
            pcall(function()
                require("mason-registry").refresh()
            end)
        end,
        event = "User FileOpened",
        lazy = true,
    },
}
