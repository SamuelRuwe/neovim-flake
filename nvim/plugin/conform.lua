require('conform').setup {
  formatters_by_ft = {
    lua = { 'stylua' },
    -- Conform will run multiple formatters sequentially
    rust = { 'rustfmt', lsp_format = 'fallback' },
    -- Conform will run the first available formatter
    javascript = { 'prettierd', 'prettier', lsp_format = 'fallback', stop_after_first = true },
    javascriptreact = { 'prettierd', 'prettier', lsp_format = 'fallback', stop_after_first = true },
    typescript = { 'prettierd', 'prettier', lsp_format = 'fallback', stop_after_first = true },
    typescriptreact = { 'prettierd', 'prettier', lsp_format = 'fallback', stop_after_first = true },
  },
}

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function(args)
    require('conform').format { bufnr = args.buf }
  end,
})
