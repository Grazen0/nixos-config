return {
  {
    'rachartier/tiny-devicons-auto-colors.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'VeryLazy',
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
    main = 'ibl',
    opts = { indent = { char = '│' } },
  },
  {
    's1n7ax/nvim-window-picker',
    config = true,
  },
  {
    'stevearc/dressing.nvim',
    opts = { input = { default_prompt = 'Rename' } },
  },
}
