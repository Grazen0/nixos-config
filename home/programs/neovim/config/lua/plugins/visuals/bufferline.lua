return {
  'akinsho/bufferline.nvim',
  lazy = false,
  opts = {
    options = {
      themable = true,
      numbers = 'none',
      separator_style = 'thin',
    },
  },
  keys = {
    { 'H', '<cmd>BufferLineCyclePrev<CR>', desc = 'Cycle to previous buffer' },
    { 'L', '<cmd>BufferLineCycleNext<CR>', desc = 'Cycle to next buffer' },
    {
      '<leader>bmn',
      '<cmd>BufferLineMoveNext<CR>',
      desc = 'Move buffer after next',
    },
    {
      '<leader>bmp',
      '<cmd>BufferLineMovePrev<CR>',
      desc = 'Move buffer before previous',
    },
    { '<leader>bc', '<cmd>BufferLinePick<CR>', desc = 'Pick buffer' },
    {
      '<leader>bC',
      '<cmd>BufferLineCloseOthers<CR>',
      desc = 'Close other buffers',
    },
  },
}
