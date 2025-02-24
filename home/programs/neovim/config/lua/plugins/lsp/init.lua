return {
  {
    'windwp/nvim-ts-autotag',
    config = true,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    config = true,
  },
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    config = true,
  },
  {
    'ray-x/lsp_signature.nvim',
    config = true,
  },
  {
    'jmbuhr/otter.nvim',
    ft = { 'markdown', 'quarto' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    keys = {
      { '<leader>oa', require('otter').activate, desc = 'Activate otter' },
      { '<leader>od', require('otter').deactivate, desc = 'Deactivate otter' },
    },
  },
  {
    'smjonas/inc-rename.nvim',
    lazy = false,
    opts = {
      input_buffer_type = 'dressing',
    },
    keys = {
      {
        '<leader>rn',
        function()
          return ':IncRename ' .. vim.fn.expand('<cword>')
        end,
        expr = true,
        desc = 'Rename symbol',
      },
    },
  },
}
