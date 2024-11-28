require('trouble').setup({
  modes = {
    test = {
      mode = 'diagnostics',
      preview = {
        type = 'split',
        relative = 'win',
        position = 'right',
        size = 0.3,
      },
    },
  },
})

local keyset = vim.keymap.set

keyset(
  'n',
  '<leader>xx',
  '<cmd>Trouble diagnostics toggle<cr>',
  { desc = 'Diagnostics (Trouble)' }
)
keyset(
  'n',
  '<leader>xX',
  '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
  { desc = 'Buffer Diagnostics (Trouble)' }
)
keyset(
  'n',
  '<leader>cs',
  '<cmd>Trouble symbols toggle focus=false<cr>',
  { desc = 'Symbols (Trouble)' }
)
keyset(
  'n',
  '<leader>cl',
  '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
  { desc = 'LSP Definitions / references / ... (Trouble)' }
)
keyset(
  'n',
  '<leader>xL',
  '<cmd>Trouble loclist toggle<cr>',
  { desc = 'Location List (Trouble)' }
)
keyset(
  'n',
  '<leader>xQ',
  '<cmd>Trouble qflist toggle<cr>',
  { desc = 'Quickfix List (Trouble)' }
)
