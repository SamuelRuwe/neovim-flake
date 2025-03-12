local opts = {
  plugins = { spelling = true },
  defaults = {
    mode = { 'n', 'v' },
  },
}
local wk = require('which-key')
wk.setup(opts)
wk.add(opts.defaults)
