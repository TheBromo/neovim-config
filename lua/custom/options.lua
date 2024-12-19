-- encoding
vim.opt.fileencoding = "utf-8"
vim.opt.spelllang = "en"

-- Sync clipboard between OS and Neovim.
vim.o.clipboard = "unnamed"

-- Enable break indent
vim.o.breakindent = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.termguicolors = true

vim.opt.signcolumn = "yes"
-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10
-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

-- line handling
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 999
vim.opt.sidescrolloff = 8
vim.opt.wrap = false

vim.opt.colorcolumn = "120"

-- file backups
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true

-- indents
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- other
vim.opt.termguicolors = true
vim.opt.conceallevel = 1

vim.opt.shortmess = "IF"
vim.g.have_nerd_font = true

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- set update time for lsp hover
vim.opt.updatetime = 250


vim.opt.fillchars = {
    horiz = '━',
    horizup = '┻',
    horizdown = '┳',
    vert = '┃',
    vertleft = '┫',
    vertright = '┣',
    verthoriz =
    '╋',
}

vim.o.background = "dark"
-- extend comment when hitting ENTER in insert mode
vim.opt.formatoptions:append("r")

-- local function set_tmux_status(status)
--     os.execute("tmux set status " .. status)
-- end
--
-- -- Create autocmds for entering and leaving Neovim
-- vim.api.nvim_create_autocmd("VimEnter", {
--     callback = function()
--         set_tmux_status("off")
--     end,
-- })
--
-- vim.api.nvim_create_autocmd("VimLeave", {
--     callback = function()
--         set_tmux_status("on")
--     end,
-- })
