vim.diagnostic.config({ virtual_text = false })

require('tiny-inline-diagnostic').setup({
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
})
