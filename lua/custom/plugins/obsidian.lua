return {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",

    -- from https://github.com/epwalsh/obsidian.nvim/blob/86caccdac82e78a268e25fab901f47bc36ccd33c/lua/obsidian/commands/init.lua#L6-L21
    cmd = {
        "ObsidianCheck",
        "ObsidianToday",
        "ObsidianYesterday",
        "ObsidianTomorrow",
        "ObsidianNew",
        "ObsidianOpen",
        "ObsidianBacklinks",
        "ObsidianSearch",
        "ObsidianTemplate",
        "ObsidianQuickSwitch",
        "ObsidianLinkNew",
        "ObsidianLink",
        "ObsidianFollowLink",
        "ObsidianWorkspace",
        "ObsidianRename",
        "ObsidianPasteImg",
    },
    keys = {
        { "<leader>tt", "<cmd>ObsidianToday<cr>" },
        { "<leader>nn", "<cmd>ObsidianQuickSwitch<cr>" },
        { "<leader>fn", "<cmd>ObsidianSearch<cr>" },
    },

    dependencies = {
        -- Required.
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
        "nvim-telescope/telescope.nvim",
    },
    opts = {
        workspaces = {
            {
                name = "nexus",
                path = "~/Documents/nexus",
            },
        },
    },
}
