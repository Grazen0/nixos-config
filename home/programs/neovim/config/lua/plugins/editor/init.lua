require('plugins.editor.cmp')
require('plugins.editor.autopairs')
require('plugins.editor.multicursor')
require('plugins.editor.neo-tree')
require('plugins.editor.spectre')
require('plugins.editor.fzf-lua')
require('plugins.editor.ultisnips')

require('nvim-surround').setup()
require('Comment').setup()

-- yazi.nvim
vim.keymap.set('n', '<leader>-', '<cmd>Yazi<CR>')

-- bullets.vim
vim.g.bullets_enabled_file_types = {
  'markdown',
  'text',
  'gitcommit',
  'scratch',
  'quarto',
}
vim.g.bullets_outline_levels = { 'std-' }

-- undotree
vim.keymap.set('n', '<leader>u', '<cmd>UndotreeShow<CR>')

-- lazygit.nvim
vim.keymap.set('n', '<leader>lg', '<cmd>LazyGit<CR>')
