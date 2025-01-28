local which_key = require('which-key')
which_key.setup({
  delay = 1000,
  win = { border = 'rounded' },
})

vim.keymap.set('n', '<leader>?', function()
  which_key.show({ global = false })
end)
