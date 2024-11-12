require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
    disable = { 'latex' },
  },
})

vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldmethod = 'expr'
vim.opt.foldlevel = 99
