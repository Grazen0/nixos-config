require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
    disable = { 'latex' },
  },
  indent = { enable = true },
})

vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldmethod = 'expr'
vim.opt.foldlevel = 99
