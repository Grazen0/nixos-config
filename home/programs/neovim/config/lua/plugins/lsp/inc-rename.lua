return {
  'smjonas/inc-rename.nvim',
  dependencies = { 'stevearc/dressing.nvim' },
  opts = {
    input_buffer_type = 'dressing',
    override = function(conf)
      conf.col = -1
      conf.row = 0
      return conf
    end,
  },
}
