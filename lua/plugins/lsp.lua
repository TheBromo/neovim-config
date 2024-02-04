return {
  {
    event = 'VeryLazy',
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 
      'j-hui/fidget.nvim', 
      opts = {
          notification = {
          override_vim_notify = true,
          }
        }
      
      },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
  },
  },
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },

    cmd = { 'Trouble', 'TroubleToggle' },
    keys = {
      { '<leader>xx', '<cmd>TroubleToggle<cr>' },
      { '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>' },
      { '<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>' },
    },

    opts = {
     
    },
  },

}
