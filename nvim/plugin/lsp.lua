local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

lspconfig.ts_ls.setup {
  capabilities = capabilities,
}
