return {
  'akinsho/bufferline.nvim',
  opts = {
    options = {
      themable = true,
      numbers = 'none',
      separator_style = 'thin',
    },
  },
  config = function(_, opts)
    require('bufferline').setup(opts)

    local keyset = vim.keymap.set
    keyset('n', 'H', '<cmd>BufferLineCyclePrev<CR>')
    keyset('n', 'L', '<cmd>BufferLineCycleNext<CR>')
    keyset('n', '<leader>bmn', '<cmd>BufferLineMoveNext<CR>')
    keyset('n', '<leader>bmp', '<cmd>BufferLineMovePrev<CR>')
    keyset('n', '<leader>bc', '<cmd>BufferLinePick<CR>')
    keyset('n', '<leader>bC', '<cmd>BufferLineCloseOthers<CR>')
  end,
}
