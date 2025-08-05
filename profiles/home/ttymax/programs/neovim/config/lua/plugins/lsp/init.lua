return {
  {
    'windwp/nvim-ts-autotag',
    ft = {
      'html',
      'javascript',
      'typescript',
      'javascriptreact',
      'typescriptreact',
      'svelte',
      'markdown',
      'php',
      'vue',
      'xml',
    },
    main = 'nvim-ts-autotag',
    opts = {
      opts = {
        enable_close_on_slash = true,
      },
    },
  },
  {
    'jmbuhr/otter.nvim',
    enabled = false,
    ft = { 'markdown', 'quarto' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    keys = {
      {
        '<leader>oa',
        function()
          require('otter').activate()
        end,
        desc = 'Activate otter',
      },
      {
        '<leader>od',
        function()
          require('otter').deactivate()
        end,
        desc = 'Deactivate otter',
      },
    },
  },
  {
    'mrcjkb/rustaceanvim',
    enabled = false,
    event = 'VeryLazy',
    init = function()
      vim.g.rustaceanvim = {
        tools = {
          hover_actions = { border = vim.o.winborder },
        },
      }
    end,
  },
  {
    'Civitasv/cmake-tools.nvim',
    ft = { 'cpp', 'cmake' },
    dependencies = { 'nvim-lua/plenary.nvim', 'stevearc/overseer.nvim' },
    main = 'cmake-tools',
    opts = {},
  },
}
