local blink = require('blink.cmp')

blink.setup {
  completion = {
    ghost_text = {
      enabled = true,
    },
    accept = { auto_brackets = { enabled = true } },
    menu = {
      draw = {
        columns = {
          { 'label', 'label_description', gap = 1 },
          { 'kind_icon' },
        },
      },
    },
  },
  appearance = {
    nerd_font_variant = 'mono',
  },
  sources = {
    default = { 'lsp', 'path' },
  },
}

vim.lsp.enable('ts_ls')
vim.lsp.enable('lua_ls')

vim.lsp.config('ts_ls', {
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
})

vim.lsp.config('lua_ls', {
  capabilities = blink.get_lsp_capabilities(),
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'bit', 'it', 'describe', 'before_each', 'after_each' },
      },
    },
  },
})

vim.lsp.enable('pyright')
vim.lsp.config('pyright', {
  capabilities = blink.get_lsp_capabilities(),
})

vim.lsp.enable('hls')
vim.lsp.config('hls', {
  filetypes = { 'haskell', 'lhaskell', 'cabal' },
})

vim.lsp.enable('nixd')
vim.lsp.config('nixd', {
  capabilities = blink.get_lsp_capabilities(),
  settings = {
    nixd = {
      nixpkgs = {
        expr = 'import <nixpkgs> { }',
      },
      formatting = {
        command = { 'nixfmt' },
      },
      options = {
        home_manager = {
          expr = '(builtins.getFlake ("~/nixos" + toString ./.)).homeConfigurations."desktop".options',
        },
      },
    },
  },
})
