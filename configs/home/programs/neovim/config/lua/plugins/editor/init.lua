return {
  {
    'kylechui/nvim-surround',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'windwp/nvim-ts-autotag',
    event = 'VeryLazy',
    opts = {},
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
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = 'Spectre',
    opts = {},
  },
}
