vim.loader.enable()

require('opts')
require('maps')
require('autocmds')
require('user-commands')

require('lazy').setup({
  performance = {
    reset_packpath = false,
    rtp = { reset = false },
  },
  dev = {
    path = require('nix').lazy_dev_path,
    patterns = { '' },
  },
  install = { missing = false },
  change_detection = { enabled = false },
  spec = {
    { import = 'plugins.visuals' },
    { import = 'plugins.editor' },
    { import = 'plugins.lsp' },
    { import = 'plugins.misc' },
  },
  ui = { border = 'single' },
})
