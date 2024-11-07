require('nvim-navbuddy').setup({
  window = {
    border = 'none',
  },
  lsp = {
    auto_attach = true,
  },
})

vim.keymap.set('n', '<leader>n', '<cmd>Navbuddy<CR>')
