return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPost', 'BufNewFile' },
  cmd = { 'LspInfo', 'LspInstall', 'LspUninstall' },
  dependencies = {
    'saghen/blink.cmp',
  },
  opts = {
    servers = {
      bashls = {},
      clangd = {},
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
    },
    signs = {
      Error = ' ',
      Warn = ' ',
      Hint = ' ',
      Info = ' ',
    },
    diagnostic_border = 'single',
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
        border = opts.diagnostic_border,
      })
    vim.lsp.handlers['textDocument/signatureHelp'] =
      vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = opts.diagnostic_border,
      })
    vim.diagnostic.config({
      float = { border = opts.diagnostic_border },
    })

    for type, icon in pairs(opts.signs) do
      local hl = 'DiagnosticSign' .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
    end

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
