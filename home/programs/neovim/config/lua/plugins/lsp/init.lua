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
    opts = {},
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
    opts = {},
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
    'pmizio/typescript-tools.nvim',
    ft = {
      'javascript',
      'javascriptreact',
      'javascript.jsx',
      'typescript',
      'typescriptreact',
      'typescript.tsx',
    },
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {},
  },
}
