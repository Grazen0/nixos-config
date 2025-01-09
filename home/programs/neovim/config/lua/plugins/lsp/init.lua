require('nvim-ts-autotag').setup()
require('treesitter-context').setup()

require('plugins.lsp.conform')
require('plugins.lsp.navbuddy')
require('plugins.lsp.tiny-inline-diagnostic')
require('plugins.lsp.treesitter')
require('plugins.lsp.trouble')
require('plugins.lsp.inc-rename')

require('lazydev').setup()
require('lsp_signature').setup()

-- otter.nvim
local otter = require('otter')
vim.keymap.set('n', '<leader>oa', otter.activate)
vim.keymap.set('n', '<leader>od', otter.deactivate)
