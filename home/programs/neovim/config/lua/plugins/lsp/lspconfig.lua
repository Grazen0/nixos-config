return {
  'neovim/nvim-lspconfig',
  dependencies = {
    {
      'SmiteshP/nvim-navbuddy',
      dependencies = {
        'SmiteshP/nvim-navic',
        'MunifTanjim/nui.nvim',
      },
      opts = {
        window = { border = 'none' },
        lsp = { auto_attach = true },
      },
      keys = {
        { '<leader>n', '<cmd>Navbuddy<CR>', desc = 'Open Navbuddy' },
      },
    },
  },
  config = function()
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

    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    local lspconfig = require('lspconfig')

    local function setup_lsp(server, opts)
      opts = opts or {}
      opts.capabilities = opts.capabilities or capabilities
      lspconfig[server].setup(opts)
    end

    -- Scripting and other stuff
    setup_lsp('bashls')
    setup_lsp('clangd')
    setup_lsp('nil_ls')
    setup_lsp('lua_ls')

    -- Web dev
    setup_lsp('ts_ls')
    setup_lsp('eslint')
    setup_lsp('html')
    setup_lsp('emmet_language_server')
    setup_lsp('cssls')
    setup_lsp('tailwindcss')
    setup_lsp('svelte')

    -- Other cool stuff
    setup_lsp('pyright')
    setup_lsp('rust_analyzer')
    setup_lsp('texlab')
    setup_lsp('java_language_server')
    setup_lsp('hls')

    -- Build tools
    setup_lsp('cmake')
    setup_lsp('autotools_ls')
    setup_lsp('taplo')
    setup_lsp('vimls')

    local schemastore = require('schemastore')

    setup_lsp('jsonls', {
      settings = {
        json = {
          schemas = schemastore.json.schemas(),
          validate = { enable = true },
        },
      },
    })
    setup_lsp('yamlls', {
      settings = {
        yaml = {
          schemaStore = {
            enable = false,
            url = '',
          },
          schemas = schemastore.yaml.schemas(),
        },
      },
    })
  end,
}
