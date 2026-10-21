local M = {}

local function highlight(name)
	return vim.api.nvim_get_hl(0, { name = name, link = false, create = false })
end

function M.apply()
	local normal = highlight("Normal")
	local comment = highlight("Comment")
	local visual = highlight("Visual")
	local float = highlight("NormalFloat")
	local separator = highlight("WinSeparator")
	local context_bg = highlight("CursorLine").bg or visual.bg or float.bg or normal.bg
	local cursor_bg = normal.bg or float.bg
	local accent = highlight("DiagnosticWarn").fg or highlight("Constant").fg or normal.fg

	-- Reverse video also works when the theme inherits a transparent background.
	local cursor = { reverse = true }
	if normal.bg and normal.fg then
		cursor = { fg = normal.bg, bg = normal.fg }
	end
	vim.api.nvim_set_hl(0, "Cursor", cursor)
	vim.api.nvim_set_hl(0, "CursorLine", { bg = context_bg })
	if not visual.reverse then
		visual.fg = normal.fg
		visual.bg = visual.bg or context_bg
	end
	vim.api.nvim_set_hl(0, "Visual", visual)
	vim.api.nvim_set_hl(0, "TroubleNormal", { fg = normal.fg, bg = "NONE" })
	vim.api.nvim_set_hl(0, "TroubleNormalNC", { fg = normal.fg, bg = "NONE" })
	vim.api.nvim_set_hl(0, "WinSeparator", { fg = separator.fg or comment.fg, bg = "NONE" })
	vim.api.nvim_set_hl(0, "IndentBlanklineChar", { link = "Comment" })
	vim.api.nvim_set_hl(0, "TreesitterContext", { bg = context_bg })
	vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { bg = context_bg })
	vim.api.nvim_set_hl(0, "TreesitterContextBottom", { bg = context_bg, underline = true })
	vim.api.nvim_set_hl(0, "CursorLineNr", { fg = normal.fg })

	-- Use the theme's warning accent for static multicursors in Ghostty.
	local multicursor = { reverse = true, bold = true }
	if cursor_bg and accent then
		multicursor = { fg = cursor_bg, bg = accent, bold = true }
	end
	vim.api.nvim_set_hl(0, "MCursor", multicursor)
	vim.api.nvim_set_hl(0, "MCursorVisual", { link = "Visual" })
end

return M
