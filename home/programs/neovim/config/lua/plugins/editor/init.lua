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

local keyset = vim.keymap.set

-- undotree
keyset('n', '<leader>u', '<cmd>UndotreeShow<CR>')

-- lazygit.nvim
keyset('n', '<leader>lg', '<cmd>LazyGit<CR>')

-- vim-tmux-navigator
keyset('n', '<cmd>TmuxNavigateLeft<CR>', 'window left')
keyset('n', '<cmd>TmuxNavigateDown<CR>', 'window down')
keyset('n', '<cmd>TmuxNavigateUp<CR>', 'window up')
keyset('n', '<cmd>TmuxNavigateRight<CR>', 'window right')
