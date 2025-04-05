return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPost', 'BufNewFile' },
  cmd = { 'LspInfo', 'LspInstall', 'LspUninstall' },
  dependencies = { 'saghen/blink.cmp' },
  opts = {
    servers = {
      bashls = {},
      clangd = {
        cmd = {
          'clangd',
          '--background-index',
          '--clang-tidy',
          '--completion-style=detailed',
          '--header-insertion=iwyu',
          '--pch-storage=memory',
        },
      },
      nil_ls = {},
      lua_ls = {},
      ts_ls = {},
      eslint = {},
      html = {},
      emmet_language_server = {},
      cssls = {},
      svelte = {},
      pyright = {},
      texlab = {},
      r_language_server = {},
      zls = {},
      cmake = {},
      autotools_ls = {},
      taplo = {},
      vimls = {},
      jsonls = {
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
          },
        },
      },
      yamlls = {
        {
          settings = {
            yaml = {
              schemaStore = {
                enable = false,
                url = '',
              },
              schemas = require('schemastore').yaml.schemas(),
            },
          },
        },
      },
      arduino_language_server = {},
    },
    diagnostic_config = {
      float = {
        border = 'single',
      },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = ' ',
          [vim.diagnostic.severity.WARN] = ' ',
          [vim.diagnostic.severity.HINT] = ' ',
          [vim.diagnostic.severity.INFO] = ' ',
        },
      },
    },
    default_capabilities = {
      textDocument = {
        foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true,
        },
      },
    },
  },
  config = function(_, opts)
    -- https://vi.stackexchange.com/questions/39074/user-borders-around-lsp-floating-windows
    vim.lsp.handlers['textDocument/hover'] =
      vim.lsp.with(vim.lsp.handlers.hover, {
        border = 'single',
      })
    vim.lsp.handlers['textDocument/signatureHelp'] =
      vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = 'single',
      })
    vim.diagnostic.config(opts.diagnostic_config)

    local lspconfig = require('lspconfig')
    local blink = require('blink.cmp')

    for server, config in pairs(opts.servers) do
      config.capabilities = vim.tbl_deep_extend(
        'force',
        blink.get_lsp_capabilities(config.capabilities),
        opts.default_capabilities
      )
      lspconfig[server].setup(config)
    end
  end,
}
