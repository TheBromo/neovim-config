return {
	"rmagatti/auto-session",
	lazy = false,

	---enables autocomplete for opts
	---@module "auto-session"
	---@type AutoSession.Config
	opts = {
		allowed_dirs = { "~/Development/*", "~/.config/*" },
		use_git_branch = true,
	},
}
