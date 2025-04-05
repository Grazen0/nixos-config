return {
  'kevinhwang91/nvim-ufo',
  event = 'BufRead',
  dependencies = { 'kevinhwang91/promise-async' },
  keys = {
    {
      'K',
      function()
        local winid = require('ufo').peekFoldedLinesUnderCursor()
        if not winid then
          vim.lsp.buf.hover({ border = 'single' })
        end
      end,
      desc = 'Preview fold or LSP hover',
    },
    {
      'zR',
      function()
        require('ufo').openAllFolds()
      end,
    },
    {
      'zM',
      function()
        require('ufo').closeAllFolds()
      end,
    },
    {
      'zr',
      function()
        require('ufo').openFoldsExceptKinds()
      end,
    },
    {
      'zm',
      function()
        require('ufo').closeFoldsWith()
      end,
    },
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
