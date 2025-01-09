local spectre = require('spectre')
local keyset = vim.keymap.set

keyset('n', '<leader>S', spectre.toggle, {
  desc = 'Toggle Spectre',
})
keyset('n', '<leader>sw', function()
  spectre.open_visual({ select_word = true })
end, {
  desc = 'Search current word',
})
keyset('v', '<leader>sw', function()
  vim.api.nvim_feedkeys('', 't', true)
  spectre.open_visual()
end, {
  desc = 'Search current word',
})
keyset('n', '<leader>sp', function()
  spectre.open_file_search({ select_word = true })
end, {
  desc = 'Search on current file',
})
