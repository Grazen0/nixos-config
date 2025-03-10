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
    event = 'LspAttach',
    priority = 1000,
    opts = {
      preset = 'simple',
      options = {
        multilines = { enabled = true },
        use_icons_from_diagnostic = true,
      },
    },
    config = function(_, opts)
      require('tiny-inline-diagnostic').setup(opts)
      vim.diagnostic.config({ virtual_text = false })
    end,
  },
}
