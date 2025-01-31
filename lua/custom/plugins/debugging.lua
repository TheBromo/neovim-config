return {
	{

		"mfussenegger/nvim-dap",
		dependencies = {
			"leoluz/nvim-dap-go",
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
			"williamboman/mason.nvim",
		},
		config = function()
			local dap = require("dap")
			local ui = require("dapui")

			require("dapui").setup()
			require("dap-go").setup()

			require("nvim-dap-virtual-text").setup({ enabled = true }) -- Handled by nvim-dap-go

			-- dap.adapters.go = {
			--   type = "server",
			--   port = "${port}",
			--   executable = {
			--     command = "dlv",
			--     args = { "dap", "-l", "127.0.0.1:${port}" },
			--   },
			-- }

			vim.keymap.set("n", "<space>b", dap.toggle_breakpoint, { desc = "Toggle [B]reakpoint" })
			vim.keymap.set("n", "<space>br", dap.run_to_cursor, { desc = "Run to [B]reakpoint" })

			-- Eval var under cursor
			vim.keymap.set("n", "<space>?", function()
				require("dapui").eval(nil, { enter = true })
			end, { desc = "Eval under cursor" })

			vim.keymap.set("n", "<F1>", dap.continue, { desc = "Debugger: continue" })
			vim.keymap.set("n", "<F2>", dap.step_into, { desc = "Debugger: step into" })
			vim.keymap.set("n", "<F3>", dap.step_over, { desc = "Debugger: step over" })
			vim.keymap.set("n", "<F4>", dap.step_out, { desc = "Debugger: step ou" })
			vim.keymap.set("n", "<F5>", dap.step_back, { desc = "Debugger: step back" })
			vim.keymap.set("n", "<F13>", dap.restart, { desc = "Debugger: restart" })

			dap.listeners.before.attach.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				ui.open()
			end

			dap.listeners.before.event_terminated.dapui_config = function()
				ui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				ui.close()
			end
		end,
	},
}
