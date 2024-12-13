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

require('tiny-code-action').setup()

vim.keymap.set('n', '<leader>ca', function()
  require('tiny-code-action').code_action({})
end, { silent = true })
