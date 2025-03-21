return {
  'norcalli/nvim-colorizer.lua',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    filetypes = {
      'nix',
      'css',
      'sass',
      'scss',
      'javascript',
      'typescript',
      html = { names = false },
      javascriptreact = { names = false },
      typescriptreact = { names = false },
      svelte = { names = false },
    },
  },
}
