local spectre = require('spectre')

return {
  'nvim-pack/nvim-spectre',
  cmd = 'Spectre',
  config = function(_, opts)
    require('spectre').setup(opts)
  end,
  keys = {
    { '<leader>S', spectre.toggle, desc = 'Toggle Spectre' },
    {
      '<leader>sw',
      function()
        spectre.open_visual({ select_word = true })
      end,
      { desc = 'Search current word' },
    },
    {
      '<leader>sw',
      function()
        vim.api.nvim_feedkeys('', 't', true)
        spectre.open_visual()
      end,
      { desc = 'Search current word' },
    },
    {
      '<leader>sp',
      function()
        spectre.open_file_search({ select_word = true })
      end,
      { desc = 'Search on current file' },
    },
  },
}
