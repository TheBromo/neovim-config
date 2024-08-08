return {
    "stevearc/oil.nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' },

    event = "VeryLazy",
    config = function()
        require("oil").setup()
        vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end,

    opts = {
        default_file_explorer = true,
        skip_confirm_for_simple_edits = true,
    },
}
