return {
  'kevinhwang91/nvim-ufo',
  enabled = false,
  event = 'BufRead',
  dependencies = { 'kevinhwang91/promise-async' },
  keys = {
    {
      'K',
      function()
        local winid = require('ufo').peekFoldedLinesUnderCursor()
        if not winid then
          vim.lsp.buf.hover()
        end
      end,
      desc = 'Preview fold or LSP hover',
    },
    { 'zR', require('ufo').openAllFolds },
    { 'zM', require('ufo').closeAllFolds },
    { 'zr', require('ufo').openFoldsExceptKinds },
    { 'zm', require('ufo').closeFoldsWith },
    'zc',
    'zC',
    'zo',
    'zO',
  },
  init = function()
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
  end,
  opts = {
    enable_get_fold_virt_text = true,
    preview = {
      win_config = { border = 'single' },
    },
  },
}
