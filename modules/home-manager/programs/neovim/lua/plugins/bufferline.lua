local bufferline = require('bufferline')

bufferline.setup({
  options = {
    numbers = 'none',
    separator_style = 'thick',
    style_preset = bufferline.style_preset.no_italic,
  },
})

local keyset = vim.keymap.set
keyset('n', 'H', '<cmd>BufferLineCyclePrev<CR>')
keyset('n', 'L', '<cmd>BufferLineCycleNext<CR>')
keyset('n', '<leader>bmn', '<cmd>BufferLineMoveNext<CR>')
keyset('n', '<leader>bmp', '<cmd>BufferLineMovePrev<CR>')
keyset('n', '<leader>bc', '<cmd>BufferLinePick<CR>')
