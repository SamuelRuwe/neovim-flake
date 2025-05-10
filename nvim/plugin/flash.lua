local flash = require('flash')
flash.setup {}

vim.keymap.set('n', 's', function()
  flash.jump()
end, { desc = 'Flash' })
