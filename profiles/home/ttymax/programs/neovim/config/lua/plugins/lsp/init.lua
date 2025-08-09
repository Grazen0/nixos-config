return {
  {
    'barreiroleo/ltex-extra.nvim',
    enabled = false,
    ft = { 'markdown', 'quarto', 'tex', 'typst' },
    dependencies = { 'neovim/nvim-lspconfig' },
    name = 'ltex_extra.nvim',
    opts = {
      load_langs = { 'en-US', 'es' },
      path = '.vscode',
      server_opts = {
        capabilities = require('blink.cmp').get_lsp_capabilities(),
      },
    },
  },
}
