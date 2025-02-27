return {
  {
    'saghen/blink.compat',
    lazy = true,
    opts = {},
  },
  {
    'saghen/blink.cmp',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = { 'L3MON4D3/luasnip' },
    opts = function()
      local blink = require('blink.cmp')

      return {
        keymap = {
          preset = 'enter',
          ['<Tab>'] = {
            function()
              local ls = require('luasnip')

              if ls.expandable() then
                blink.hide()
                vim.schedule(ls.expand)
                return true
              end
            end,
            'snippet_forward',
            'fallback',
          },
        },
        cmdline = {
          keymap = {
            preset = 'enter',
            ['<Tab>'] = { 'show', 'select_next', 'fallback' },
            ['<S-Tab>'] = { 'select_prev', 'fallback' },
          },
        },
        snippets = { preset = 'luasnip' },
        sources = {
          default = {
            'lsp',
            'path',
            'snippets',
            'buffer',
            'lazydev',
            'obsidian',
            'obsidian_new',
            'obsidian_tags',
          },
          providers = {
            lazydev = {
              name = 'LazyDev',
              module = 'lazydev.integrations.blink',
              score_offset = 100,
            },
            obsidian = {
              name = 'obsidian',
              module = 'blink.compat.source',
            },
            obsidian_new = {
              name = 'obsidian_new',
              module = 'blink.compat.source',
            },
            obsidian_tags = {
              name = 'obsidian_tags',
              module = 'blink.compat.source',
            },
          },
        },
        signature = { enabled = true },
        completion = {
          ghost_text = { enabled = true },
          documentation = {
            auto_show = true,
            auto_show_delay_ms = 500,
          },
          list = {
            selection = {
              preselect = false,
              auto_insert = false,
            },
          },
          menu = {
            draw = {
              columns = {
                { 'label', 'label_description', gap = 1 },
                { 'kind_icon', 'kind', gap = 1 },
              },
            },
            auto_show = function(ctx)
              return ctx.mode ~= 'cmdline'
            end,
          },
        },
      }
    end,
  },
}
