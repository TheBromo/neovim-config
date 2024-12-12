return {
    -- unused
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    config = function()
        local theme = require("lualine.themes.auto")

        -- lualine
        require('lualine').setup {
            options = {
                icons_enabled = false,
                theme = theme,
                component_separators = "|",
                section_separators = {},
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = {
                    'filename',

                    function()
                        return vim.fn['nvim_treesitter#statusline'](180)
                    end },
                lualine_x = { 'encoding', 'fileformat', 'filetype' },
                lualine_y = { 'progress' },
                lualine_z = { 'location' }
            },
        }
    end

}
