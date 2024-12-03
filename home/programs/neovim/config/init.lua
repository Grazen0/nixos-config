require('opts')
require('maps')
require('autocmds')
require('user-commands')
require('lsp')

-- Loaded before in order to apply highlights properly
require('plugins.visuals')
require('plugins.editor')
require('plugins.lsp')
require('plugins.misc')

-- Gotta do this again for some reason
vim.cmd('colorscheme kanagawa')
