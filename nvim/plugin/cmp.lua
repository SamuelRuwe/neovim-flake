local blink = require('blink.cmp')
blink.setup {
  keymap = { preset = 'default' },

  enabled = function()
    return vim.bo.buftype ~= 'prompt'
  end,

  completion = {
    menu = {
      enabled = true,
      min_width = 15,
      max_height = 10,
      border = 'none',
      winblend = 0,
      winhighlight = 'Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None',
      scrolloff = 2,
      scrollbar = true,
      direction_priority = { 's', 'n' },
      auto_show = true,
      draw = {},
    },

    documentation = {
      auto_show = false,
      auto_show_delay_ms = 500,
      update_delay_ms = 50,
      treesitter_highlighting = true,
      window = {
        min_width = 10,
        max_width = 60,
        max_height = 20,
        border = 'padded',
        winblend = 0,
        winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None',
        scrollbar = true,
        direction_priority = {
          menu_north = { 'e', 'w', 'n', 's' },
          menu_south = { 'e', 'w', 's', 'n' },
        },
      },
    },
    -- Displays a preview of the selected item on the current line
    ghost_text = {
      enabled = true,
    },
  },

  -- Experimental signature help support
  -- signature = {
  --   enabled = false,
  --   trigger = {
  --     blocked_trigger_characters = {},
  --     blocked_retrigger_characters = {},
  --     show_on_insert_on_trigger_character = true,
  --   },
  --   window = {
  --     min_width = 1,
  --     max_width = 100,
  --     max_height = 10,
  --     border = 'padded',
  --     winblend = 0,
  --     winhighlight = 'Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder',
  --     scrollbar = false, -- Note that the gutter will be disabled when border ~= 'none'
  --     -- Which directions to show the window,
  --     -- falling back to the next direction when there's not enough space,
  --     -- or another window is in the way
  --     direction_priority = { 'n', 's' },
  --     -- Disable if you run into performance issues
  --     treesitter_highlighting = true,
  --   },
  -- },

  -- fuzzy = {
  --   -- when enabled, allows for a number of typos relative to the length of the query
  --   -- disabling this matches the behavior of fzf
  --   use_typo_resistance = true,
  --   -- frecency tracks the most recently/frequently used items and boosts the score of the item
  --   use_frecency = true,
  --   -- proximity bonus boosts the score of items matching nearby words
  --   use_proximity = true,
  --   -- controls which sorts to use and in which order, these three are currently the only allowed options
  --   sorts = { 'label', 'kind', 'score' },
  --
  --   prebuilt_binaries = {
  --     download = true,
  --     force_version = nil,
  --     force_system_triple = nil,
  --   },
  -- },

  -- sources = {
  --   default = { 'lsp', 'path', 'snippets', 'buffer' },
  --   completion = {},
  --
  --   -- Please see https://github.com/Saghen/blink.compat for using `nvim-cmp` sources
  --   providers = {
  --     lsp = {
  --       name = 'LSP',
  --       module = 'blink.cmp.sources.lsp',
  --
  --       --- *All* of the providers have the following options available
  --       --- NOTE: All of these options may be functions to get dynamic behavior
  --       --- See the type definitions for more information.
  --       --- Check the enabled_providers config for an example
  --       enabled = true, -- Whether or not to enable the provider
  --       transform_items = nil, -- Function to transform the items before they're returned
  --       should_show_items = true, -- Whether or not to show the items
  --       max_items = nil, -- Maximum number of items to display in the menu
  --       min_keyword_length = 0, -- Minimum number of characters in the keyword to trigger the provider
  --       fallbacks = { 'buffer' }, -- If any of these providers return 0 items, it will fallback to this provider
  --       score_offset = 0, -- Boost/penalize the score of the items
  --       override = nil, -- Override the source's functions
  --     },
  --     path = {
  --       name = 'Path',
  --       module = 'blink.cmp.sources.path',
  --       score_offset = 3,
  --       opts = {
  --         trailing_slash = false,
  --         label_trailing_slash = true,
  --         get_cwd = function(context)
  --           return vim.fn.expand(('#%d:p:h'):format(context.bufnr))
  --         end,
  --         show_hidden_files_by_default = false,
  --       },
  --     },
  --     snippets = {
  --       name = 'Snippets',
  --       module = 'blink.cmp.sources.snippets',
  --       score_offset = -3,
  --       opts = {
  --         friendly_snippets = true,
  --         search_paths = { vim.fn.stdpath('config') .. '/snippets' },
  --         global_snippets = { 'all' },
  --         extended_filetypes = {},
  --         ignored_filetypes = {},
  --         get_filetype = function(context)
  --           return vim.bo.filetype
  --         end,
  --       },
  --     },
  --     buffer = {
  --       name = 'Buffer',
  --       module = 'blink.cmp.sources.buffer',
  --       min_keyword_length = 5,
  --       max_items = 3,
  --       opts = {
  --         -- default to all visible buffers
  --         get_bufnrs = function()
  --           return vim
  --             .iter(vim.api.nvim_list_wins())
  --             :map(function(win)
  --               return vim.api.nvim_win_get_buf(win)
  --             end)
  --             :filter(function(buf)
  --               return vim.bo[buf].buftype ~= 'nofile'
  --             end)
  --             :totable()
  --         end,
  --       },
  --     },
  --   },
  -- },

  appearance = {
    highlight_ns = vim.api.nvim_create_namespace('blink_cmp'),
    use_nvim_cmp_as_default = false,
    nerd_font_variant = 'mono',
    kind_icons = {
      Text = '󰉿',
      Method = '󰊕',
      Function = '󰊕',
      Constructor = '󰒓',

      Field = '󰜢',
      Variable = '󰆦',
      Property = '󰖷',

      Class = '󱡠',
      Interface = '󱡠',
      Struct = '󱡠',
      Module = '󰅩',

      Unit = '󰪚',
      Value = '󰦨',
      Enum = '󰦨',
      EnumMember = '󰦨',

      Keyword = '󰻾',
      Constant = '󰏿',

      Snippet = '󱄽',
      Color = '󰏘',
      File = '󰈔',
      Reference = '󰬲',
      Folder = '󰉋',
      Event = '󱐋',
      Operator = '󰪚',
      TypeParameter = '󰬛',
    },
  },
}
