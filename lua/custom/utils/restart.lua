local utils = {}

function utils.restart_neovim()
	local args = vim.fn.argv()
	local command = { vim.v.progpath, unpack(args) }
	local job_id = vim.fn.jobstart(command, { detach = true })
	if job_id > 0 then
		vim.cmd("quitall!")
	else
		print("Failed to restart Neovim")
	end
end

_G.utils = utils
