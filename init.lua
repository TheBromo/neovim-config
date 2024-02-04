vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
require('plugins')

require('options')
require('mappings')

require('telescope-setup')
require('treesitter-setup')
require('lsp-setup')
require('cmp-setup')
