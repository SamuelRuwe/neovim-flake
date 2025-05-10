local lspconfig = require('lspconfig')
local blink = require('blink.cmp')

blink.setup {
  completion = {
    ghost_text = {
      enabled = true,
    },
  },
  appearance = {
    nerd_font_variant = 'mono',
  },
  sources = {
    default = { 'lazydev', 'lsp', 'path', 'buffer' },
    providers = {
      lazydev = {
        name = 'lazydev',
        module = 'lazydev.integrations.blink',
        score_offset = 100,
      },
    },
  },
}

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

lspconfig.pyright.setup {
  capabilities = blink.get_lsp_capabilities(),
}

lspconfig.hls.setup {
  filetypes = { 'haskell', 'lhaskell', 'cabal' },
}
