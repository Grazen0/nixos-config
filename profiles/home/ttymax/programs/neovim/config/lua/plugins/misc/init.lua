return {
  {
    'tpope/vim-obsession',
    event = 'VeryLazy',
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show({ global = false })
        end,
        desc = 'Buffer Local Keymaps (which-key)',
      },
    },
    opts = {
      win = { border = vim.o.winborder },
      preset = 'helix',
    },
  },
  {
    'iamcco/markdown-preview.nvim',
    ft = { 'markdown', 'quarto' },
    init = function()
      vim.g.mkdp_filetypes = { 'markdown', 'quarto' }
    end,
  },
  {
    'Saecki/crates.nvim',
    ft = { 'rust', 'toml' },
    opts = {},
  },
  {
    'azratul/live-share.nvim',
    cmd = { 'LiveShareJoin', 'LiveShareServer' },
    dependencies = {
      {
        'jbyuki/instant.nvim',
        init = function()
          vim.g.instant_username = 'Grazen'
        end,
      },
    },
    opts = {},
  },
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {},
  },
  {
    'lervag/vimtex',
    ft = { 'tex', 'plaintex' },
    init = function()
      vim.g.vimtex_view_method = 'zathura'
    end,
  },
  {
    'j-hui/fidget.nvim',
    event = 'VeryLazy',
    opts = {
      notification = {
        override_vim_notify = true,
      },
    },
  },
  {
    'jghauser/mkdir.nvim',
    enabled = false,
    event = 'BufWritePre',
  },
  {
    'kndndrj/nvim-dbee',
    dependencies = { 'MunifTanjim/nui.nvim' },
    cmd = 'Dbee',
    opts = {},
  },
  {
    'mpas/marp-nvim',
    cmd = { 'MarpStart', 'MarpStatus', 'MarpToggle' },
    opts = {},
  },
  {
    'RaafatTurki/hex.nvim',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'scalameta/nvim-metals',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'j-hui/fidget.nvim',
        opts = {},
      },
      {
        'mfussenegger/nvim-dap',
        config = function(self, opts)
          -- Debug settings if you're using nvim-dap
          local dap = require('dap')

          dap.configurations.scala = {
            {
              type = 'scala',
              request = 'launch',
              name = 'RunOrTest',
              metals = {
                runType = 'runOrTestFile',
                --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
              },
            },
            {
              type = 'scala',
              request = 'launch',
              name = 'Test Target',
              metals = {
                runType = 'testTarget',
              },
            },
          }
        end,
      },
    },
    ft = { 'scala', 'sbt', 'java' },
    opts = function()
      local metals_config = require('metals').bare_config()

      metals_config.init_options.statusBarProvider = 'off'

      metals_config.capabilities = require('blink.cmp').get_lsp_capabilities({})

      metals_config.on_attach = function()
        vim.keymap.set('n', 'gD', vim.lsp.buf.definition)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references)
        vim.keymap.set('n', 'gds', vim.lsp.buf.document_symbol)
        vim.keymap.set('n', 'gws', vim.lsp.buf.workspace_symbol)
        vim.keymap.set('n', '<leader>grn', vim.lsp.buf.rename)
        vim.keymap.set('n', '<leader>gra', vim.lsp.buf.code_action)

        vim.keymap.set('n', '<leader>ws', function()
          require('metals').hover_worksheet()
        end)

        vim.keymap.set('n', '[d', function()
          vim.diagnostic.jump({ count = -1, float = true, wrap = false })
        end)

        vim.keymap.set('n', ']d', function()
          vim.diagnostic.jump({ count = 1, float = true, wrap = false })
        end)
      end

      return metals_config
    end,
    config = function(self, metals_config)
      local nvim_metals_group =
        vim.api.nvim_create_augroup('nvim-metals', { clear = true })
      vim.api.nvim_create_autocmd('FileType', {
        pattern = self.ft,
        callback = function()
          require('metals').initialize_or_attach(metals_config)
        end,
        group = nvim_metals_group,
      })
    end,
  },
}
