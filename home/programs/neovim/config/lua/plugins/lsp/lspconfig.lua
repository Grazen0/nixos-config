return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'saghen/blink.cmp',
    'SmiteshP/nvim-navbuddy',
    'themaxmarchuk/tailwindcss-colors.nvim',
  },
  opts = {
    servers = {
      -- Scripting and other stuff
      bashls = {},
      clangd = {},
      nil_ls = {},
      lua_ls = {},

      -- Web dev
      -- eslint = {},
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
      r_language_server = {},
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
    local lspconfig = require('lspconfig')
    local blink = require('blink.cmp')

    for server, config in pairs(opts.servers) do
      config.capabilities = blink.get_lsp_capabilities(config.capabilities)
      lspconfig[server].setup(config)
    end
  end,
}
