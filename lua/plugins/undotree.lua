return {
	specs = { "https://github.com/mbbill/undotree" },
	setup = function()
		vim.keymap.set("n", "<leader>du", "<cmd>UndotreeToggle<cr>", { desc = "[D]ocument [U]ndotree" })
	end,
}
