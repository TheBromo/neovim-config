-- Clear search highlights and finish the current multicursor session.
local multicursor_ns = vim.api.nvim_create_namespace("nvim.multicursor")
vim.keymap.set("n", "<Esc>", function()
	vim.cmd.nohlsearch()
	vim.api.nvim_buf_clear_namespace(0, multicursor_ns, 0, -1)
end, { desc = "Clear search highlights and multicursors" })

vim.keymap.set("n", "\\", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })

vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
