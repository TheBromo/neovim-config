return {
	specs = { "https://github.com/dmtrKovalenko/fff.nvim" },
	setup = function()
		require("fff").setup({ prompt = "🦖 " })

		vim.keymap.set("n", "<leader>sf", function()
			require("fff").find_files()
		end, { desc = "FFFind FFFiles" })

		vim.keymap.set("n", "<leader>sg", function()
			require("fff").live_grep()
		end, { desc = "Live grep" })

		vim.keymap.set("n", "<leader>sw", function()
			require("fff").live_grep({ query = vim.fn.expand("<cword>") })
		end, { desc = "Search current word" })

		vim.keymap.set("n", "<leader>sz", function()
			require("fff").live_grep({
				grep = {
					modes = { "fuzzy", "plain" },
				},
			})
		end, { desc = "Fuzzy grep" })
	end,
}
