local telescope = require('telescope')
telescope.setup {
  pickers = {
    find_files = {
      theme = 'ivy',
    },
  },
  extensions = {
    fzf = {},
  },
}

telescope.load_extension('fzf')

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]earch [F]iles' })
vim.keymap.set('n', '<leader>fr', function()
  builtin.oldfiles { cwd = vim.uv.cwd() }
end, { desc = '[F]earch [R]ecent Files' })

vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[F]ind existing [B]uffers' })
vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })

vim.keymap.set(
  'n',
  '<leader>,',
  '<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>',
  { desc = 'Switch Buffer' }
)

vim.keymap.set('n', '<leader>:', builtin.command_history, { desc = 'Command History' })
vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = '[F]ind [Git] Files (git-files)' })
vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = '[Git] [C]ommits' })
vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = '[Git] [S]tatus' })
vim.keymap.set('n', '<leader>s"', builtin.registers, { desc = 'Registers' })
vim.keymap.set('n', '<leader>sa', builtin.autocommands, { desc = '[S]earch [A]uto Commands' })
vim.keymap.set('n', '<leader>sb', builtin.current_buffer_fuzzy_find, { desc = '[S]earch Current [B]uffer' })
vim.keymap.set('n', '<leader>sc', builtin.command_history, { desc = '[S]earch [C]ommand History' })
vim.keymap.set('n', '<leader>sC', builtin.commands, { desc = '[S]earch [C]ommands' })
vim.keymap.set('n', '<leader>sd', '<cmd>Telescope diagnostics bufnr=0<cr>', { desc = 'Document Diagnostics' })
vim.keymap.set('n', '<leader>sH', builtin.highlights, { desc = '[S]earch [H]ighlight Groups' })
vim.keymap.set('n', '<leader>sj', builtin.jumplist, { desc = '[S]earch [J]umplist' })
vim.keymap.set('n', '<leader>sl', builtin.loclist, { desc = '[S]earch [L]ocation List' })
vim.keymap.set('n', '<leader>sM', builtin.man_pages, { desc = '[S]earch [M]an Pages' })
vim.keymap.set('n', '<leader>sm', builtin.marks, { desc = '[S]earch [Marks]' })
vim.keymap.set('n', '<leader>so', builtin.vim_options, { desc = '[S]earch [O]ptions' })
vim.keymap.set('n', '<leader>sq', builtin.quickfix, { desc = '[S]earch [Q]uickfix List' })

local plugin_path = vim.g.sams_super_secret_plugin_path
if plugin_path then
  vim.keymap.set('n', '<space>fp', function()
    builtin.find_files {
      follow = true,
      cwd = plugin_path,
    }
  end, { desc = '[Find] [P]lugins' })
end
