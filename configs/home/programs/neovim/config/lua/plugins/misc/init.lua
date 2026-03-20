return {
  {
    'kndndrj/nvim-dbee',
    dependencies = { 'MunifTanjim/nui.nvim' },
    cmd = 'Dbee',
    opts = {},
  },
  {
    'chomosuke/typst-preview.nvim',
    ft = 'typst',
    opts = {
      open_cmd = require('nix').browser .. ' --new-window %s',
    },
    keys = {
      { '<localleader>tp', '<cmd>TypstPreview<cr>' },
    },
  },
}
