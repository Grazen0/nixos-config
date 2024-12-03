require('nvim-navbuddy').setup({
  window = {
    border = 'rounded',
  },
  lsp = {
    auto_attach = true,
  },
})

vim.keymap.set('n', '<leader>n', '<cmd>Navbuddy<CR>')
