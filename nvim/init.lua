require('sam')

-- local cmd = vim.cmd
-- local fn = vim.fn
-- local opt = vim.o
-- local g = vim.g
--
-- -- Enable true colour support
-- if fn.has('termguicolors') then
--   opt.termguicolors = true
-- end
--
-- vim.opt.path = vim.o.path .. '**'
--
-- vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
--
-- local function prefix_diagnostic(prefix, diagnostic)
--   return string.format(prefix .. ' %s', diagnostic.message)
-- end
--
-- vim.diagnostic.config {
--   virtual_text = {
--     prefix = '',
--     format = function(diagnostic)
--       local severity = diagnostic.severity
--       if severity == vim.diagnostic.severity.ERROR then
--         return prefix_diagnostic('󰅚', diagnostic)
--       end
--       if severity == vim.diagnostic.severity.WARN then
--         return prefix_diagnostic('⚠', diagnostic)
--       end
--       if severity == vim.diagnostic.severity.INFO then
--         return prefix_diagnostic('ⓘ', diagnostic)
--       end
--       if severity == vim.diagnostic.severity.HINT then
--         return prefix_diagnostic('󰌶', diagnostic)
--       end
--       return prefix_diagnostic('■', diagnostic)
--     end,
--   },
--   signs = {
--     text = {
--       -- Requires Nerd fonts
--       [vim.diagnostic.severity.ERROR] = '󰅚',
--       [vim.diagnostic.severity.WARN] = '⚠',
--       [vim.diagnostic.severity.INFO] = 'ⓘ',
--       [vim.diagnostic.severity.HINT] = '󰌶',
--     },
--   },
--   update_in_insert = false,
--   underline = true,
--   severity_sort = true,
--   float = {
--     focusable = false,
--     style = 'minimal',
--     border = 'rounded',
--     source = 'if_many',
--     header = '',
--     prefix = '',
--   },
-- }
--
-- g.editorconfig = true
--
-- -- Native plugins
-- cmd.filetype('plugin', 'indent', 'on')
-- cmd.packadd('cfilter') -- Allows filtering the quickfix list with :cfdo

-- let sqlite.lua (which some plugins depend on) know where to find sqlite
-- vim.g.sqlite_clib_path = require('luv').os_getenv('LIBSQLITE')