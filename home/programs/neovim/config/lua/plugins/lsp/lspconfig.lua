return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'saghen/blink.cmp',
    'SmiteshP/nvim-navbuddy',
    'themaxmarchuk/tailwindcss-colors.nvim',
    'rachartier/tiny-inline-diagnostic.nvim',
  },
  opts = {
    servers = {
      -- Scripting and other stuff
      bashls = {},
      clangd = {},
      nil_ls = {},
      lua_ls = {},

      -- Web dev
      ts_ls = {},
      eslint = {},
      html = {},
      emmet_language_server = {},
      cssls = {},
      tailwindcss = {
        on_attach = function(_, bufnr)
          require('tailwindcss-colors').buf_attach(bufnr)
        end,
      },
      svelte = {},

      -- Other cool stuff
      pyright = {},
      rust_analyzer = {},
      texlab = {},
      java_language_server = {},
      hls = {},
      zls = {},

      -- Build tools
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
  },
  config = function(_, opts)
    -- https://vi.stackexchange.com/questions/39074/user-borders-around-lsp-floating-windows
    vim.lsp.handlers['textDocument/hover'] =
      vim.lsp.with(vim.lsp.handlers.hover, {
        border = 'solid',
      })

    vim.lsp.handlers['textDocument/signatureHelp'] =
      vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = 'solid',
      })

    vim.diagnostic.config({
      float = { border = 'solid' },
    })

    local lspconfig = require('lspconfig')
    local blink = require('blink.cmp')

    for server, config in pairs(opts.servers) do
      config.capabilities = blink.get_lsp_capabilities(config.capabilities)
      lspconfig[server].setup(config)
    end
  end,
}
