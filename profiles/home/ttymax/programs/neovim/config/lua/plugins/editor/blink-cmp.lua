return {
  'saghen/blink.cmp',
  event = { 'BufReadPost', 'BufNewFile' },
  dependencies = { 'L3MON4D3/luasnip' },
  opts = function()
    local blink = require('blink.cmp')

    local function expand_scheduled()
      local ls = require('luasnip')

      if ls.expandable() then
        blink.hide()
        vim.schedule(ls.expand)
        return true
      end
    end

    return {
      keymap = {
        preset = 'enter',
        ['<Tab>'] = { expand_scheduled, 'snippet_forward', 'fallback' },
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
        },
        providers = {
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            score_offset = 100,
          },
        },
      },
      signature = {
        enabled = true,
      },
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
  config = function(_, opts)
    require('blink.cmp').setup(opts)

    vim.api.nvim_set_hl(0, 'BlinkCmpMenuBorder', { link = 'FloatBorder' })
  end,
}
