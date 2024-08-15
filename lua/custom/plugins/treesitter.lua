return {
    { 
        'nvim-treesitter/nvim-treesitter',
        lazy = false,

        build = ':TSUpdate',
        opts = {
            ensure_installed = {},
            auto_install = true,
            highlight = {
                enable = true,
            },
            indent = { enable = true, disable = { 'ruby' } },
        },
        config = function(_, opts)
            require('nvim-treesitter.install').prefer_git = true

            ---@diagnostic disable-next-line: missing-fields
            require('nvim-treesitter.configs').setup(opts)
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
        cmd = { 'TSContextEnable', 'TSContextDisable', 'TSContextToggle' },
        dependencies = { 'nvim-treesitter/nvim-treesitter' },

    },
}
