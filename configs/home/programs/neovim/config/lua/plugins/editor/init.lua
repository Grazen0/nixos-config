return {
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
      { '<leader>u', '<cmd>UndotreeShow<cr>', desc = 'Show undotree' },
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
      { '<c-h>', '<cmd><c-u>TmuxNavigateLeft<cr>' },
      { '<c-j>', '<cmd><c-u>TmuxNavigateDown<cr>' },
      { '<c-k>', '<cmd><c-u>TmuxNavigateUp<cr>' },
      { '<c-l>', '<cmd><c-u>TmuxNavigateRight<cr>' },
      { '<C-\\>', '<cmd><c-u>TmuxNavigatePrevious<cr>' },
    },
  },
  {
    'nmac427/guess-indent.nvim',
    opts = {},
  },
  {
    'nvim-pack/nvim-spectre',
    opts = {},
    keys = {
      { '<c-s>' },
    },
  },
  {
    'nvim-pack/nvim-spectre',
    cmd = 'Spectre',
    opts = {},
  },
}
