return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'saghen/blink.cmp',
    'themaxmarchuk/tailwindcss-colors.nvim',
  },
  opts = {
    servers = {
      -- Scripting and other stuff
      bashls = {},
      clangd = {},
      nixd = {},
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
      rust_analyzer = {
        settings = {
          ['rust-analyzer'] = {
            checkOnSave = { command = 'clippy' },
          },
        },
      },
      texlab = {},
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
    signs = {
      Error = ' ',
      Warn = ' ',
      Hint = '󰌶 ',
      Info = ' ',
    },
  },
  config = function(_, opts)
    for type, icon in pairs(opts.signs) do
      local hl = 'DiagnosticSign' .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
    end

    local lspconfig = require('lspconfig')
    local blink = require('blink.cmp')

    for server, config in pairs(opts.servers) do
      config.capabilities = blink.get_lsp_capabilities(config.capabilities)
      lspconfig[server].setup(config)
    end
  end,
}
