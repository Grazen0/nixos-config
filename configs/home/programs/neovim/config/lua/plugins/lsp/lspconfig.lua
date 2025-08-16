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
        cssls = {},
        denols = {
          root_dir = util.root_pattern('deno.json', 'deno.jsonc'),
        },
        emmet_language_server = {},
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
        kotlin_language_server = {},
        lua_ls = {
          on_init = function(client)
            if client.workspace_folders then
              local path = client.workspace_folders[1].name
              if
                  path ~= vim.fn.stdpath('config')
                  and (
                  --- @diagnostic disable: undefined-field
                    vim.uv.fs_stat(path .. '/.luarc.json')
                    or vim.uv.fs_stat(path .. '/.luarc.jsonc')
                  )
              then
                return
              end
            end

            client.config.settings.Lua =
                vim.tbl_deep_extend('force', client.config.settings.Lua, {
                  runtime = {
                    version = 'LuaJIT',
                    path = { 'lua/?.lua', 'lua/?/init.lua' },
                  },
                  workspace = {
                    checkThirdParty = false,
                    library = { vim.env.VIMRUNTIME },
                  },
                })
          end,
          settings = { Lua = {} },
        },
        metals = {},
        nil_ls = {},
        pyright = {},
        rust_analyzer = {
          settings = {
            ['rust-analyzer'] = { check = { command = 'clippy' } },
          },
        },
        statix = {},
        svelte = {},
        tailwindcss = {},
        texlab = {},
        tinymist = {},
        ts_ls = {
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

    local blink = require('blink.cmp')

    for server, config in pairs(opts.servers) do
      vim.lsp.enable(server)

      config.capabilities = vim.tbl_deep_extend(
        'force',
        blink.get_lsp_capabilities(config.capabilities),
        opts.default_capabilities
      )
      vim.lsp.config(server, config)
    end
  end,
}
