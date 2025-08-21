return {
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
    'folke/todo-comments.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
  },
  {
    'iamcco/markdown-preview.nvim',
    ft = { 'markdown', 'quarto' },
    init = function()
      vim.g.mkdp_filetypes = { 'markdown', 'quarto' }
    end,
  },
  {
    'lervag/vimtex',
    ft = { 'tex', 'plaintex' },
    init = function()
      vim.g.vimtex_view_method = 'zathura'
    end,
  },
  {
    'kndndrj/nvim-dbee',
    dependencies = { 'MunifTanjim/nui.nvim' },
    cmd = 'Dbee',
    opts = {},
  },
  {
    'chomosuke/typst-preview.nvim',
    ft = 'typst',
    opts = {
      open_cmd = require('nix').browser .. ' --new-window %s',
    },
    keys = {
      { '<localleader>tp', '<cmd>TypstPreview<cr>' },
    },
  },
  {
    'scalameta/nvim-metals',
    enabled = false,
    dependencies = { 'nvim-lua/plenary.nvim', 'j-hui/fidget.nvim' },
    ft = { 'scala', 'sbt' },
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
