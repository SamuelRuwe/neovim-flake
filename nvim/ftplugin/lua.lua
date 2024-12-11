vim.bo.comments = ':---,:--'

local lua_ls_cmd = 'lua-language-server'

-- Check if lua-language-server is available
if vim.fn.executable(lua_ls_cmd) ~= 1 then
  return
end

local root_files = {
  '.luarc.json',
  '.luarc.jsonc',
  '.luacheckrc',
  '.stylua.toml',
  'stylua.toml',
  'selene.toml',
  'selene.yml',
  '.git',
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_lsp = require('cmp_nvim_lsp')
local cmp_lsp_capabilities = cmp_lsp.default_capabilities()
capabilities = vim.tbl_deep_extend('keep', capabilities, cmp_lsp_capabilities)

vim.lsp.start {
  name = 'lua_ls',
  cmd = { lua_ls_cmd },
  root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = {
          'vim',
          'describe',
          'it',
          'assert',
          'stub',
        },
        disable = {
          'duplicate-set-field',
        },
      },
      workspace = {
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
      hint = { -- inlay hints (supported in Neovim >= 0.10)
        enable = true,
      },
    },
  },
}
