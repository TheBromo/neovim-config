return {
    event = "VeryLazy",
    'folke/which-key.nvim',  
     opts = {}, 
    config = function()
local wk = require("which-key")

wk.register({
  x = {
    name = "+trouble", -- Group name
    x = "Toggle Trouble",
    w = "Workspace Diagnostics",
    d = "Document Diagnostics",
  },
}, { prefix = "<leader>" })

wk.register({
  f = {
    name = "+telescope", -- Group name
    f = "Find Files",
    g = "Grep",
    b = "Find in Buffer",
    h = "Find Help Tags",
  },
}, { prefix = "<leader>" })

    end
}
