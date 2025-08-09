return {
  {
    'kylechui/nvim-surround',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {},
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
  {
    'nmac427/guess-indent.nvim',
    opts = {},
  },
}
