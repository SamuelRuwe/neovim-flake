local neotest = require('neotest')
neotest.setup {
  adapters = {
    require('neotest-jest'),
  },
}

vim.keymap.set('n', '<leader>t', '', { desc = '+test' })

vim.keymap.set('n', '<leader>tt', function()
  neotest.run.run(vim.fn.expand('%'))
end, { desc = 'Run File (Neotest)' })

vim.keymap.set('n', '<leader>tT', function()
  neotest.run.run(vim.uv.cwd())
end, { desc = 'Run All Test Files (Neotest)' })

vim.keymap.set('n', '<leader>tr', function()
  neotest.run.run()
end, { desc = 'Run Nearest (Neotest)' })
vim.keymap.set('n', '<leader>tl', function()
  neotest.run.run_last()
end, { desc = 'Run Last (Neotest)' })
vim.keymap.set('n', '<leader>ts', neotest.summary.toggle, { desc = 'Toggle Summary (Neotest)' })
vim.keymap.set('n', '<leader>to', function()
  neotest.output.open { enter = true, auto_close = true }
end, { desc = 'Show Output (Neotest)' })

vim.keymap.set('n', '<leader>tO', neotest.output_panel.toggle, { desc = 'Toggle Output Panel (Neotest)' })

vim.keymap.set('n', '<leader>tS', neotest.run.stop, { desc = 'Stop (Neotest)' })

vim.keymap.set('n', '<leader>tw', function()
  neotest.watch.toggle(vim.fn.expand('%'))
end, { desc = 'Toggle Watch' })
