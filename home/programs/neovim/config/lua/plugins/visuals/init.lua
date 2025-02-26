return {
  {
    'RRethy/vim-illuminate',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('illuminate').configure()
    end,
  },
  {
    'rachartier/tiny-devicons-auto-colors.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
  },
  {
    'themaxmarchuk/tailwindcss-colors.nvim',
    main = 'tailwindcss-colors',
    lazy = true,
    opts = {},
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    main = 'ibl',
    opts = {
      indent = { char = '│' },
      exclude = {
        filetypes = {
          'help',
          'alpha',
          'dashboard',
          'neo-tree',
          'Trouble',
          'lazy',
        },
      },
    },
  },
  {
    -- TODO: proper highlights with kanagawa
    's1n7ax/nvim-window-picker',
    lazy = true,
    opts = {},
  },
  {
    'stevearc/dressing.nvim',
    lazy = true,
    opts = { input = { default_prompt = 'Rename' } },
  },
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 500,
      },
    },
  },
}
