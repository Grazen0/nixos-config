vim.diagnostic.config({ virtual_text = false })

require('tiny-inline-diagnostic').setup({
  blend = {
    factor = 0.1,
  },
  options = {
    multilines = true,
    virt_texts = {
      priority = 50,
    },
  },
})
