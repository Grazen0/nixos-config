return {
  'rachartier/tiny-inline-diagnostic.nvim',
  lazy = true,
  opts = {
    hi = {
      mixing_color = '#16161d',
    },
    blend = {
      factor = 0.2,
    },
    options = {
      multilines = true,
      virt_texts = {
        priority = 50,
      },
    },
  },
  config = function(_, opts)
    require('tiny-inline-diagnostic').setup(opts)
    vim.diagnostic.config({ virtual_text = false })
  end,
}
