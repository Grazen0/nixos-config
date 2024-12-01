local capabilities = require('cmp_nvim_lsp').default_capabilities()

local function setup_lsp(server, opts)
  opts = opts or {}
  opts.capabilities = opts.capabilities or capabilities

  require('lspconfig')[server].setup(opts)
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
