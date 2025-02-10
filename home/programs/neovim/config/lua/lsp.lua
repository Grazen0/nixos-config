-- https://vi.stackexchange.com/questions/39074/user-borders-around-lsp-floating-windows
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'rounded',
})

vim.lsp.handlers['textDocument/signatureHelp'] =
  vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = 'rouded',
  })

vim.diagnostic.config({
  float = { border = 'rounded' },
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')

local function setup_lsp(server, opts)
  opts = opts or {}
  opts.capabilities = opts.capabilities or capabilities
  lspconfig[server].setup(opts)
end

local function setup_lsp_lazy(server, opts)
  local autocmd_id
  autocmd_id = vim.api.nvim_create_autocmd('FileType', {
    pattern = lspconfig[server].config_def.default_config.filetypes,
    callback = function()
      vim.api.nvim_del_autocmd(autocmd_id)
      setup_lsp(server, opts)
    end,
  })
end

-- At least one of these must be non-lazy in order
-- for r.nvim to initialize properly

-- Scripting and other stuff
setup_lsp('bashls')
setup_lsp_lazy('clangd')
setup_lsp_lazy('nil_ls')
setup_lsp_lazy('lua_ls')

-- Web dev
setup_lsp_lazy('ts_ls')
setup_lsp_lazy('eslint')
setup_lsp_lazy('html')
setup_lsp_lazy('emmet_language_server')
setup_lsp_lazy('cssls')
setup_lsp_lazy('tailwindcss')
setup_lsp_lazy('svelte')

-- Other cool stuff
setup_lsp('pyright')
setup_lsp('rust_analyzer')
setup_lsp_lazy('texlab')
setup_lsp_lazy('java_language_server')
setup_lsp_lazy('hls')

-- Build tools
setup_lsp_lazy('cmake')
setup_lsp_lazy('autotools_ls')
setup_lsp_lazy('taplo')
setup_lsp_lazy('vimls')

local schemastore = require('schemastore')

setup_lsp_lazy('jsonls', {
  settings = {
    json = {
      schemas = schemastore.json.schemas(),
      validate = { enable = true },
    },
  },
})
setup_lsp_lazy('yamlls', {
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
