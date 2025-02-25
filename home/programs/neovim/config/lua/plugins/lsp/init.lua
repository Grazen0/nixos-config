return {
  {
    'windwp/nvim-ts-autotag',
    ft = {
      'html',
      'javascript',
      'typescript',
      'javascriptreact',
      'typescriptreact',
      'markdown',
      'svelte',
      'php',
      'xml',
    },
    config = true,
  },
  {
    'SmiteshP/nvim-navbuddy',
    dependencies = {
      'SmiteshP/nvim-navic',
      'MunifTanjim/nui.nvim',
    },
    opts = {
      window = { border = 'none' },
      lsp = { auto_attach = true },
    },
    keys = {
      { '<leader>n', '<cmd>Navbuddy<CR>', desc = 'Open Navbuddy' },
    },
  },
  {
    'folke/lazydev.nvim',
    ft = 'lua',
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
