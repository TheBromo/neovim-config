-- Enable faster startup by caching compiled Lua modules
vim.loader.enable()

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- Enable break indent
vim.o.breakindent = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

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


-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true


-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 20
-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

-- line handling
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.sidescrolloff = 8
vim.opt.wrap = false

vim.opt.colorcolumn = "120"
vim.opt.timeoutlen = 300

-- file backups
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true

-- indents
-- vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- other
vim.opt.termguicolors = true
vim.opt.conceallevel = 1

vim.opt.shortmess:append("I")
vim.g.have_nerd_font = true

-- set update time for lsp hover
vim.opt.updatetime = 250

vim.opt.fillchars = {
	horiz = "━",
	horizup = "┻",
	horizdown = "┳",
	vert = "┃",
	vertleft = "┫",
	vertright = "┣",
	verthoriz = "╋",
}

vim.o.background = "dark"
-- extend comment when hitting ENTER in insert mode
vim.opt.formatoptions:append("r")

vim.opt.shell = "zsh"

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
