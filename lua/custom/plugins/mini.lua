return {
    { -- Collection of various small independent plugins/modules
        "echasnovski/mini.nvim",
        event = "BufEnter",
        config = function()
            require("mini.cursorword").setup()
            require("mini.pairs").setup()
        end,
    },
}
