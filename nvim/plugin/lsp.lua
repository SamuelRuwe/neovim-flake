local lspconfig = require('lspconfig')
local blink = require('blink.cmp')

vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

lspconfig.ts_ls.setup {
  capabilities = blink.get_lsp_capabilities(),
  settings = {
    complete_function_calls = true,
    typescript = {
      updateImportsOnFileMove = { enabled = 'always' },
      suggest = {
        completeFunctionCalls = true,
      },
      inlayHints = {
        enumMemberValues = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        parameterNames = { enabled = 'literals' },
        parameterTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        variableTypes = { enabled = false },
      },
    },
  },
}

lspconfig.lua_ls.setup {
  capabilities = blink.get_lsp_capabilities(),
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'bit', 'it', 'describe', 'before_each', 'after_each' },
      },
    },
  },
}
