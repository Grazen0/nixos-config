return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPost', 'BufNewFile' },
  cmd = { 'LspInfo', 'LspInstall', 'LspUninstall' },
  dependencies = { 'saghen/blink.cmp' },
  opts = function()
    local util = require('lspconfig.util')

    return {
      servers = {
        autotools_ls = {},
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
        cmake = {},
        cssls = {},
        denols = {
          root_dir = util.root_pattern('deno.json', 'deno.jsonc'),
        },
        eslint = {},
        gopls = {},
        html = {},
        jsonls = {
          settings = {
            json = {
              schemas = require('schemastore').json.schemas(),
              validate = { enable = true },
            },
          },
        },
        ltex_plus = {},
        lua_ls = {},
        -- metals = {},
        nil_ls = {},
        pyright = {},
        -- r_language_server = {},
        rust_analyzer = {
          settings = {
            ['rust-analyzer'] = { check = { command = 'clippy' } },
          },
        },
        svelte = {},
        tailwindcss = {},
        texlab = {},
        tinymist = {},
        vtsls = {
          root_dir = util.root_pattern('package.json'),
          single_file_support = false,
        },
        yamlls = {
          settings = {
            yaml = {
              schemas = require('schemastore').yaml.schemas(),
              schemaStore = { enable = false, url = '' },
            },
          },
        },
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
