return {
  {
    'kylechui/nvim-surround',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {},
  },
  {
    'numToStr/comment.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {},
  },
  {
    'nvim-pack/nvim-spectre',
    cmd = 'Spectre',
    opts = {},
  },
  {
    'mikavilpas/yazi.nvim',
    keys = {
      {
        '<leader>-',
        mode = { 'n', 'v' },
        '<cmd>Yazi<cr>',
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
      { '<leader>u', '<cmd>UndotreeShow<CR>', desc = 'Open undotree' },
    },
  },
  {
    'kdheepak/lazygit.nvim',
    enabled = false,
    lazy = true,
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'Open LazyGit' },
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
