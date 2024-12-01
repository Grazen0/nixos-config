require('plugins.misc.mini-sessions')
require('plugins.misc.mini-starter')
require('plugins.misc.todo-comments')
require('plugins.misc.vimtex')

require('live-share').setup()
require('crates').setup()
require('hex').setup()
require('neocord').setup()

require('fidget').setup({ notification = { window = { winblend = 0 } } })

-- markdown-preview.nvim
vim.g.mkdp_filetypes = { 'markdown' }

-- instant.nvim
vim.g.instant_username = 'Grazen'
