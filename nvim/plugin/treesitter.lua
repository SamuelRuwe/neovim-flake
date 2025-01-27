local parser_install_dir = vim.fn.stdpath('cache') .. '/treesitters'
vim.fn.mkdir(parser_install_dir, 'p')
vim.opt.runtimepath:append(parser_install_dir)

require('nvim-treesitter.configs').setup {
  parser_install_dir = parser_install_dir,
  ensure_installed = {},
  sync_install = false,
  auto_install = false,
  ignore_install = { 'all' },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  additional_vim_regex_highlighting = true,
  modules = {},
}
