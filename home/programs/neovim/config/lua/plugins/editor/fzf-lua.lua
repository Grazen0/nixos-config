local fzf_lua = require('fzf-lua')
local actions = fzf_lua.actions

fzf_lua.setup({
  actions = {
    ['ctrl-x'] = actions.file_split,
  },
})

local keyset = vim.keymap.set
keyset('n', '<leader>ff', '<cmd>FzfLua files<CR>')
keyset('n', '<leader>fg', '<cmd>FzfLua live_grep_native<CR>')
keyset('n', '<leader>fb', '<cmd>FzfLua buffers<CR>')
keyset('n', '<leader>fh', '<cmd>FzfLua helptags<CR>')
keyset('n', '<leader>fr', '<cmd>FzfLua lsp_references<CR>')
keyset('n', '<leader>fi', '<cmd>FzfLua lsp_implementations<CR>')
keyset('n', '<leader>fd', '<cmd>FzfLua lsp_declarations<CR>')
