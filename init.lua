require("options")
require("mappings")
require("autocommands")

local plugin_modules = {
	"plugins.guess_indent",
	"plugins.fzf",
	"plugins.fff",
	"plugins.lsp",
	"plugins.completions",
	"plugins.autoformat",
	"plugins.autopairs",
	"plugins.colorscheme",
	"plugins.gitsigns",
	"plugins.mini",
	"plugins.nvimtree",
	"plugins.oil",
	"plugins.tmux",
	"plugins.unused.harpoon",
	"plugins.undotree",
	"plugins.treesitter",
	"plugins.todo",
	"plugins.fugitive",
}
-- INFO:
-- update :lua vim.pack.update()
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind, path = ev.data.spec.name, ev.data.kind, ev.data.path
		if kind ~= "install" and kind ~= "update" then return end
		if name == "fff.nvim" then
			vim.system({ "nix", "run", ".#release" }, { cwd = path }):wait()
		end
		if name == 'nvim-treesitter' then
			if not ev.data.active then vim.cmd.packadd 'nvim-treesitter' end
			vim.cmd 'TSUpdate'
			return
		end
	end,
})

local modules = {}
local all_specs = {}
for _, mod in ipairs(plugin_modules) do
	local ok, m = pcall(require, mod)
	if ok and m and m.specs then
		vim.list_extend(all_specs, m.specs)
		table.insert(modules, m)
	end
end

vim.pack.add(all_specs, { load = true })

for _, m in ipairs(modules) do
	if m.setup then m.setup() end
end
