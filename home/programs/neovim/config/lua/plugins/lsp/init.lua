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
    'SmiteshP/nvim-navbuddy',
    enabled = false,
    dependencies = {
      'SmiteshP/nvim-navic',
      'MunifTanjim/nui.nvim',
    },
    cmd = 'Nabuddy',
    keys = {
      { '<leader>n', '<cmd>Navbuddy<CR>', desc = 'Open Navbuddy' },
    },
    opts = {
      window = { border = 'single' },
      lsp = { auto_attach = true },
    },
  },
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = { 'nvim-dap-ui' },
    },
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
    'mrcjkb/rustaceanvim',
    event = 'VeryLazy',
    init = function()
      vim.g.rustaceanvim = {
        tools = {
          hover_actions = { border = 'single' },
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
  {
    'luckasRanarison/tailwind-tools.nvim',
    ft = {
      'javascript',
      'javascriptreact',
      'typescript',
      'typescriptreact',
      'css',
      'scss',
      'sass',
      'svelte',
    },
    main = 'tailwind-tools',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'neovim/nvim-lspconfig',
      'ibhagwan/fzf-lua',
    },
    opts = {
      document_color = {
        enabled = true,
        kind = 'background', -- Until debounce actually works
      },
      conceal = { enabled = true },
    },
  },
  {
    'mrcjkb/haskell-tools.nvim',
    dependencies = { 'mfussenegger/nvim-dap' },
    event = 'VeryLazy',
    init = function()
      vim.g.haskell_tools = {
        tools = {
          hover = { border = 'single' },
        },
      }
    end,
  },
}
