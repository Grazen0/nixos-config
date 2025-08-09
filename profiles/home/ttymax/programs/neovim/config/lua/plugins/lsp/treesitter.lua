return {
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPost', 'BufNewFile' },
    main = 'nvim-treesitter.configs',
    opts = {
      highlight = {
        enable = true,
        disable = { 'latex' }, -- Managed by vimtex
      },
    },
  },
}
