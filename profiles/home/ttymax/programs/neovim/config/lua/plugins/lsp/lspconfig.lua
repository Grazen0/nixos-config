return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPost', 'BufNewFile' },
  cmd = { 'LspInfo', 'LspInstall', 'LspUninstall' },
  dependencies = { 'saghen/blink.cmp' },
  opts = function()
    local util = require('lspconfig.util')

    return {
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
        -- vtsls = {
        --   root_dir = util.root_pattern('package.json'),
        --   single_file_support = false,
        -- },
        denols = {
          root_dir = util.root_pattern('deno.json', 'deno.jsonc'),
        },
        eslint = {},
        html = {},
        -- emmet_language_server = {},
        cssls = {},
        svelte = {},
        pyright = {},
        texlab = {},
        gopls = {},
        rust_analyzer = {
          settings = {
            ['rust-analyzer'] = {
              check = {
                command = 'clippy',
              },
            },
          },
        },
        -- r_language_server = {},
        -- zls = {},
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
          settings = {
            yaml = {
              schemas = require('schemastore').yaml.schemas(),
              schemaStore = { enable = false, url = '' },
            },
          },
        },
        -- arduino_language_server = {},
      },
      diagnostic_config = {
        virtual_text = true,
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
    }
  end,
  config = function(_, opts)
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
