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
		{ "<leader>nt", "<cmd>ObsidianToday<cr>",       desc = "[N]otes open [T]oday" },
		{ "<leader>nn", "<cmd>ObsidianQuickSwitch<cr>", desc = "[N]otes switch" },
		{ "<leader>ns", "<cmd>ObsidianSearch<cr>",      desc = "[N]otes text [S]earch" },
	},

	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",
		"Saghen/blink.cmp",
		"ibhagwan/fzf-lua"
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
