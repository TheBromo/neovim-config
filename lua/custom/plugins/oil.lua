return {
    "stevearc/oil.nvim",

    event = "VeryLazy",

    config = function()
        require("oil").setup()
        vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end,

    opts = {
        default_file_explorer = true,
        skip_confirm_for_simple_edits = true,
        view_options = {
            show_hidden = true,
        },

    },
}
