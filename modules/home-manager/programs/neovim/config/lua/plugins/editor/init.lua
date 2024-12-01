require('plugins.editor.cmp')
require('plugins.editor.multicursor')
require('plugins.editor.neo-tree')
require('plugins.editor.spectre')
require('plugins.editor.telescope')
require('plugins.editor.ultisnips')

require('nvim-surround').setup()
require('nvim-autopairs').setup()
require('Comment').setup()

-- undotree
vim.keymap.set('n', '<leader>u', '<cmd>UndotreeShow<CR>')

-- lazygit.nvim
vim.keymap.set('n', '<leader>lg', '<cmd>LazyGit<CR>')
