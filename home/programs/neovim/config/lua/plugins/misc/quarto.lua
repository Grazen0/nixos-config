local quarto = require('quarto')

vim.g.molten_image_provider = 'image.nvim'
vim.g.molten_wrap_output = true
vim.g.molten_output_virt_lines = true
vim.g.molten_virt_lines_off_by_1 = true

quarto.setup({
  codeRunner = { default_method = 'molten' },
})

local runner = require('quarto.runner')

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'quarto',
  callback = function()
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
    keyset(
      'n',
      '<localleader>RA',
      function()
        runner.run_all(true)
      end,
      { desc = 'run all cells of all languages', silent = true, buffer = true }
    )
  end,
})
