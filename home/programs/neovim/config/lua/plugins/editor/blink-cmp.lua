return {
  {
    'saghen/blink.compat',
    lazy = true,
    config = true,
  },
  {
    'saghen/blink.cmp',
    dependencies = { 'L3MON4D3/luasnip', 'R-nvim/cmp-r' },
    opts = {
      keymap = { preset = 'enter' },
      cmdline = {
        keymap = {
          preset = 'enter',
          ['<Tab>'] = { 'show', 'select_next', 'fallback' },
          ['<S-Tab>'] = { 'select_prev', 'fallback' },
        },
      },

      snippets = { preset = 'luasnip' },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev', 'cmp_r' },
        providers = {
          cmp_r = {
            name = 'cmp_r',
            module = 'blink.compat.source',
          },
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            score_offset = 100,
          },
        },
      },
      signature = { enabled = true },
      completion = {
        list = {
          selection = {
            preselect = false,
            auto_insert = false,
          },
        },
        menu = {
          auto_show = function(ctx)
            return ctx.mode ~= 'cmdline'
          end,
        },
      },
    },
  },
}
