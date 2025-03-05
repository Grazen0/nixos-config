return {
  {
    'RRethy/vim-illuminate',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('illuminate').configure()
    end,
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
    's1n7ax/nvim-window-picker',
    lazy = true,
    opts = {},
  },
  {
    'stevearc/dressing.nvim',
    dependencies = { 'ibhagwan/fzf-lua' },
    event = 'VeryLazy',
    opts = {
      input = {
        default_prompt = 'Rename',
        border = 'single',
      },
      select = {
        backend = { 'fzf_lua', 'builtin' },
      },
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {},
  },
}
