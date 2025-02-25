return {
  {
    'rachartier/tiny-devicons-auto-colors.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = true,
  },
  {
    -- FIX: does not work
    'themaxmarchuk/tailwindcss-colors.nvim',
    main = 'tailwindcss-colors',
    lazy = true,
    config = true,
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
    config = true,
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
