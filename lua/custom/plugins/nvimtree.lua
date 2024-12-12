return {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    config = function()
        require("nvim-tree").setup({
            update_focused_file = {
                enable = true,
            },
            view = {
                side = 'right',
            },
            renderer = {
                decorators = { "Open", "Hidden", "Modified", "Copied", "Cut", },
            }


        })
    end
}
