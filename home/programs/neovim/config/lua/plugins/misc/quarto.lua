return {
  enabled = false,
  'quarto-dev/quarto-nvim',
  ft = { 'quarto' },
  dependencies = {
    'jmbuhr/otter.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {
    codeRunner = { default_method = 'molten' },
  },
  config = function(_, opts)
    require('quarto').setup(opts)

    local runner = require('quarto.runner')
    local keyset = vim.keymap.set

    keyset(
      'n',
      '<C-CR>',
      runner.run_line,
      { desc = 'run line', silent = true, buffer = true }
    )
    keyset(
      'n',
      '<C-S-CR>',
      runner.run_cell,
      { desc = 'run cell', silent = true, buffer = true }
    )
    keyset(
      'n',
      '<C-A-P>',
      runner.run_above,
      { desc = 'run cell and above', silent = true, buffer = true }
    )
    keyset(
      'v',
      '<C-CR>',
      runner.run_range,
      { desc = 'run visual range', silent = true, buffer = true }
    )
    keyset(
      'n',
      '<localleader>Ra',
      runner.run_all,
      { desc = 'run all cells', silent = true, buffer = true }
    )
    keyset('n', '<localleader>RA', function()
      runner.run_all(true)
    end, {
      desc = 'run all cells of all languages',
      silent = true,
      buffer = true,
    })
  end,
}
