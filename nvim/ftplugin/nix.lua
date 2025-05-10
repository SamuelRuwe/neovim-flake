-- Exit if the language server isn't available
if vim.fn.executable('nil') ~= 1 then
  return
end

local root_files = {
  'flake.nix',
  'default.nix',
  'shell.nix',
  '.git',
}

local capabilities = require('blink.cmp').get_lsp_capabilities()
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- local cmp_lsp = require('cmp_nvim_lsp')
-- local cmp_lsp_capabilities = cmp_lsp.default_capabilities()
-- capabilities = vim.tbl_deep_extend('keep', capabilities, cmp_lsp_capabilities)

vim.lsp.start {
  name = 'nil_ls',
  cmd = { 'nil' },
  root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
  capabilities = capabilities,
}
