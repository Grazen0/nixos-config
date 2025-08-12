return {
  'saghen/blink.cmp',
  event = { 'BufReadPost', 'BufNewFile' },
  opts = function()
    return {
      keymap = { preset = 'enter' },
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
              { 'label',     'label_description', gap = 1 },
              { 'kind_icon', 'kind',              gap = 1 },
            },
          },
        },
      },
    }
  end,
  config = function(_, opts)
    require('blink.cmp').setup(opts)

    vim.api.nvim_set_hl(0, 'BlinkCmpMenuBorder', { link = 'FloatBorder' })
  end,
}
