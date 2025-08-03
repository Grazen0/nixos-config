return {
  {
    'kylechui/nvim-surround',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {},
  },
  {
    'mikavilpas/yazi.nvim',
    enabled = false,
    keys = {
      {
        '<leader>-',
        mode = { 'n', 'v' },
        '<cmd>Yazi<CR>',
        desc = 'Open yazi at the current file',
      },
    },
  },
  {
    'bullets-vim/bullets.vim',
    ft = { 'markdown', 'quarto' },
    init = function()
      vim.g.bullets_enabled_file_types = {
        'markdown',
        'text',
        'gitcommit',
        'scratch',
        'quarto',
      }
      vim.g.bullets_outline_levels = { 'std-' }
    end,
  },
  {
    'mbbill/undotree',
    cmd = {
      'UndotreeShow',
      'UndotreeHide',
      'UndotreeToggle',
      'UndotreeFocus',
      'UndotreePersistUndo',
    },
    keys = {
      { '<leader>u', '<cmd>UndotreeShow<CR>', desc = 'Show undotree' },
    },
  },
  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
      'TmuxNavigatorProcessList',
    },
    keys = {
      { '<C-h>', '<cmd><C-u>TmuxNavigateLeft<CR>' },
      { '<C-j>', '<cmd><C-u>TmuxNavigateDown<CR>' },
      { '<C-k>', '<cmd><C-u>TmuxNavigateUp<CR>' },
      { '<C-l>', '<cmd><C-u>TmuxNavigateRight<CR>' },
      { '<C-\\>', '<cmd><C-u>TmuxNavigatePrevious<CR>' },
    },
  },
}
