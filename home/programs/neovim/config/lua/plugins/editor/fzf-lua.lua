return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  cmd = 'FzfLua',
  opts = {
    winopts = {
      border = 'solid',
      preview = { border = 'solid' },
    },
  },
  keys = {
    { '<leader>ff', '<cmd>FzfLua files<CR>', desc = 'Find files' },
    {
      '<leader>fg',
      '<cmd>FzfLua live_grep_native<CR>',
      desc = 'Find with grep',
    },
    { '<leader>fb', '<cmd>FzfLua buffers<CR>', desc = 'Find buffers' },
    { '<leader>fh', '<cmd>FzfLua helptags<CR>', desc = 'Find help tags' },
    {
      '<leader>fr',
      '<cmd>FzfLua lsp_references<CR>',
      desc = 'Find LSP references',
    },
    {
      '<leader>fi',
      '<cmd>FzfLua lsp_implementations<CR>',
      desc = 'Find LSP implementations',
    },
    {
      '<leader>fd',
      '<cmd>FzfLua lsp_declarations<CR>',
      desc = 'Find LSP declarations',
    },
    {
      '<leader>ft',
      '<cmd>TodoFzfLua<CR>',
      desc = 'Find todo comments declarations',
    },
  },
}
