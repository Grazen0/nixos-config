return {
  'benlubas/molten-nvim',
  dependencies = { 'stevearc/dressing.nvim' },
  ft = { 'markdown', 'quarto' },

  init = function()
    vim.g.molten_wrap_output = true
    vim.g.molten_output_virt_lines = true
    vim.g.molten_virt_lines_off_by_1 = true
  end,

  config = function()
    local keyset = vim.keymap.set

    keyset(
      'n',
      '<localleader>mi',
      '<cmd>MoltenInit<CR>',
      { silent = true, buffer = true }
    )
    keyset(
      'n',
      '<localleader>md',
      '<cmd>MoltenDelete<CR>',
      { desc = 'delete Molten cell', silent = true, buffer = true }
    )
    keyset(
      'n',
      '<localleader>e',
      '<cmd>MoltenEvaluateOperator<CR>',
      { silent = true, desc = 'run operator selection', buffer = true }
    )
    keyset(
      'n',
      '<localleader>el',
      '<cmd>MoltenEvaluateLine<CR>',
      { silent = true, desc = 'evaluate line', buffer = true }
    )
    keyset(
      'n',
      '<localleader>ec',
      '<cmd>MoltenReevaluateCell<CR>',
      { silent = true, desc = 're-evaluate cell', buffer = true }
    )
    keyset(
      'v',
      '<localleader>e',
      '<cmd><C-u>MoltenEvaluateVisual<CR>gv',
      { silent = true, desc = 'evaluate visual selection', buffer = true }
    )
    keyset(
      'n',
      '<localleader>oh',
      '<cmd>MoltenHideOutput<CR>',
      { silent = true, buffer = true }
    )
    keyset(
      'n',
      '<localleader>os',
      '<cmd>MoltenEnterOutput<CR>',
      { silent = true, buffer = true }
    )
    keyset(
      'n',
      '<localleader>oi',
      '<cmd>MoltenImagePopup<CR>',
      { silent = true, buffer = true }
    )
  end,
}
