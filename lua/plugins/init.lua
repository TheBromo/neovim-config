local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  -- clone lazy if not already exists
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local status_ok, lazy = pcall(require, 'lazy')
if not status_ok then
  return
end

lazy.setup({
  require('plugins.theme'),
  require('plugins.lualine'),
  require('plugins.oil'),
  require('plugins.whichkey'),
  require('plugins.treesitter'),

  require('plugins.cursor'),

--[[
  require('plugins.snippets'),
  require('plugins.lsp'),
  require('plugins.cmp'),

  require('plugins.barbecue'),
  require('plugins.telescope'),
  require('plugins.git'),
  require('plugins.undotree'),
--]]

  }, {
  defaults = { lazy = true, },
})
