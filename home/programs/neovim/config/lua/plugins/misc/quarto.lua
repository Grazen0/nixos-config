local quarto = require('quarto')

quarto.setup()

local keyset = vim.keymap.set

keyset('n', '<leader>qp', quarto.quartoPreview, { silent = true })

local runner = require('quarto.runner')

keyset(
  'n',
  '<localleader>rc',
  runner.run_cell,
  { desc = 'run cell', silent = true }
)
keyset(
  'n',
  '<localleader>ra',
  runner.run_above,
  { desc = 'run cell and above', silent = true }
)
keyset(
  'n',
  '<localleader>rA',
  runner.run_all,
  { desc = 'run all cells', silent = true }
)
keyset(
  'n',
  '<localleader>rl',
  runner.run_line,
  { desc = 'run line', silent = true }
)
keyset(
  'v',
  '<localleader>r',
  runner.run_range,
  { desc = 'run visual range', silent = true }
)
keyset('n', '<localleader>RA', function()
  runner.run_all(true)
end, { desc = 'run all cells of all languages', silent = true })
