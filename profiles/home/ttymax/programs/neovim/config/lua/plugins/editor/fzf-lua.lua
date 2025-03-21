return {
  'ibhagwan/fzf-lua',
  event = 'VeryLazy',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  cmd = 'FzfLua',
  opts = {
    winopts = {
      border = 'single',
      preview = { border = 'single' },
    },
    hls = {
      border = 'FloatBorder',
      preview_border = 'FloatBorder',
    },
  },
  keys = {
    {
      '<leader><leader>',
      function()
        require('fzf-lua').buffers({ path_shorten = true })
      end,
      desc = 'Find buffers',
    },
    { '<leader>ff', '<cmd>FzfLua files<CR>', desc = 'Find files' },
    {
      '<leader>fg',
      '<cmd>FzfLua live_grep_native<CR>',
      desc = 'Find with grep',
    },
    { '<F1>', '<cmd>FzfLua helptags<CR>', desc = 'Find help tags' },
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
  config = function(_, opts)
    local fzf_lua = require('fzf-lua')
    fzf_lua.setup(opts)
    fzf_lua.register_ui_select()
  end,
}
