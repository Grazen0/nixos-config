return {
  'smjonas/inc-rename.nvim',
  lazy = true,
  dependencies = { 'stevearc/dressing.nvim' },
  cmd = 'IncRename',
  keys = {
    {
      '<leader>rn',
      function()
        return ':IncRename ' .. vim.fn.expand('<cword>')
      end,
      expr = true,
      desc = 'Rename symbol',
    },
  },
  opts = {
    input_buffer_type = 'dressing',
    override = function(conf)
      conf.col = -1
      conf.row = 0
      return conf
    end,
  },
}
