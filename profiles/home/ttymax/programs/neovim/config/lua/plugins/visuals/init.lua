return {
  {
    'RRethy/vim-illuminate',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('illuminate').configure()
    end,
  },
  {
    's1n7ax/nvim-window-picker',
    enabled = false,
    lazy = true,
    opts = {},
  },
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {},
  },
  {
    'rachartier/tiny-inline-diagnostic.nvim',
    enabled = false,
    event = 'LspAttach',
    priority = 1000,
    opts = {
      preset = 'simple',
      options = {
        multilines = { enabled = true },
      },
    },
    config = function(_, opts)
      require('tiny-inline-diagnostic').setup(opts)
      vim.diagnostic.config({ virtual_text = false })
    end,
  },
}
