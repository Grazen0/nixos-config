require('plugins.misc.mini-sessions')
require('plugins.misc.mini-starter')
require('plugins.misc.obsidian')
require('plugins.misc.r')
require('plugins.misc.todo-comments')
require('plugins.misc.vimtex')
require('plugins.misc.which-key')
require('plugins.misc.molten')
require('plugins.misc.quarto')

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

-- markdown-preview.nvim
vim.g.mkdp_filetypes = { 'markdown', 'vimwiki', 'quarto' }

-- instant.nvim
vim.g.instant_username = 'Grazen'
