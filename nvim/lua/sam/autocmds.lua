local v = vim.keymap.set

local function augroup(name)
  return vim.api.nvim_create_augroup('sam' .. name, { clear = true })
end

local SamsGroup = augroup('SamsGroup')

vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup('highlight_yank'),
  callback = function()
    (vim.hl or vim.highlight).on_yank()
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = augroup('close_with_q'),
  pattern = {
    'PlenaryTestPopup',
    'checkhealth',
    'dbout',
    'gitsigns-blame',
    'grug-far',
    'help',
    'lspinfo',
    'neotest-output',
    'neotest-output-panel',
    'neotest-summary',
    'notify',
    'qf',
    'spectre_panel',
    'startuptime',
    'tsplayground',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set('n', 'q', function()
        vim.cmd('close')
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = 'Quit buffer',
      })
    end)
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = SamsGroup,
  callback = function(e)
    local opts = { buffer = e.buf }
    v({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { buffer = opts.buffer, desc = 'codeAction' })
    v('n', '<leader>cc', vim.lsp.codelens.run, { buffer = opts.buffer, desc = 'codeLens' })
    v({ 'n', 'v' }, '<leader>cr', vim.lsp.buf.rename, { buffer = opts.buffer, desc = 'rename' })
    v({ 'n', 'v' }, '<leader>cl', '<cmd>LspInfo<cr>', { buffer = opts.buffer, desc = 'Lsp Info' })
  end,
})
