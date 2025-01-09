require('plugins.misc.mini-sessions')
require('plugins.misc.mini-starter')
require('plugins.misc.r')
require('plugins.misc.todo-comments')
require('plugins.misc.vimtex')

require('live-share').setup()
require('crates').setup()
require('hex').setup()
require('presence').setup({ main_image = 'file' })
require('image').setup({
  integrations = {
    markdown = { filetypes = { 'markdown', 'vimwiki', 'quarto' } },
  },
})

require('fidget').setup({
  notification = {
    window = {
      winblend = 0,
      border = 'rounded',
    },
  },
})

local which_key = require('which-key')
which_key.setup({
  delay = 1000,
  win = { wo = { winblend = 0 } },
})

vim.keymap.set('n', '<leader>?', function()
  which_key.show({ global = false })
end)

-- markdown-preview.nvim
vim.g.mkdp_filetypes = { 'markdown', 'vimwiki', 'quarto' }

-- instant.nvim
vim.g.instant_username = 'Grazen'
