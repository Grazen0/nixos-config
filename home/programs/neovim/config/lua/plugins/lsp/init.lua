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
    cmd = 'Nabuddy',
    keys = {
      { '<leader>n', '<cmd>Navbuddy<CR>', desc = 'Open Navbuddy' },
    },
    opts = {
      window = { border = 'none' },
      lsp = { auto_attach = true },
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
  {
    'mfussenegger/nvim-jdtls',
    ft = { 'java', 'kotlin', 'groovy' },
    opts = function()
      return {
        cmd = { 'jdtls' },
        root_dir = vim.fs.dirname(
          vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]
        ),
      }
    end,
    config = function(_, opts)
      local jdtls = require('jdtls')
      jdtls.start_or_attach(opts)

      vim.api.nvim_create_user_command('JdtOrganizeImports', function()
        jdtls.organize_imports()
      end, {})
    end,
  },
}
