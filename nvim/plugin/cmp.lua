local cmp = require('cmp')
local lspkind = require('lspkind')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm { select = true },
    ['<C-Space>'] = cmp.mapping.complete(),
  },
  sources = cmp.config.sources {
    { name = 'lazydev', max_item_count = 10 },
    { name = 'nvim_lsp', group_index = 1, max_item_count = 10 },
    { name = 'vsnip', max_item_count = 2 },
    { name = 'buffer', keyword_length = 5, max_item_count = 2, group_index = 2 },
  },
  experimental = {
    ghost_text = true,
  },
  formatting = {
    expandable_indicator = true,
    format = lspkind.cmp_format {
      mode = 'symbol_text',
      menu = {
        lazydev = '[LazyDev]',
        buffer = '[Buffer]',
        nvim_lsp = '[LSP]',
        luasnip = '[LuaSnip]',
        nvim_lua = '[Lua]',
      },
    },
  },
}
