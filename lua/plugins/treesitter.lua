return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    main = "nvim-treesitter.configs",

    build = ":TSUpdate",

    opts = {
      auto_install = true,

      highlight = {
        enable = true,
        disable = function(_, buf)
          return require("utils.file").is_large_buffer(buf)
        end,
      },

      indent = {
        enable = true,
        disable = function(_, buf)
          return require("utils.file").is_large_buffer(buf)
        end,
      },
    },
  },
}
