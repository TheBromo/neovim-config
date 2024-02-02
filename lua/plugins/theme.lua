return {
  'mountain-theme/vim',
  init = function()
    vim.opt.termguicolors = true;
    vim.cmd.colorscheme('mountain');
  end,
}
