return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require("neo-tree").setup({

                update_focused_file = {
                    enable = true,
                },
                filesystem = {
                    filtered_items = {
                        visible = true, -- when true, they will just be displayed differently than normal items
                    }
                }
            })
        end
    }
}
