require('plugins.misc.obsidian')
require('plugins.misc.r')
require('plugins.misc.todo-comments')
require('plugins.misc.vimtex')
require('plugins.misc.which-key')
require('plugins.misc.molten')
require('plugins.misc.quarto')

-- require('live-share').setup()
require('lib.misc').setup_on_ft({ 'rust', 'toml' }, 'crates')
-- require('hex').setup()
require('presence').setup({ main_image = 'file' })

-- markdown-preview.nvim
vim.g.mkdp_filetypes = { 'markdown', 'vimwiki', 'quarto' }

-- instant.nvim
vim.g.instant_username = 'Grazen'
