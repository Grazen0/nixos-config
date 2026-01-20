return {
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      auto_install = true,
      highlight = {
        enable = true,
        disable = { 'latex' }, -- Managed by vimtex
      },
    },
  },
}
