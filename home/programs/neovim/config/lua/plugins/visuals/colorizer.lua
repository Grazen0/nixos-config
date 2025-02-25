return {
  'norcalli/nvim-colorizer.lua',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    filetypes = {
      'nix',
      'html',
      'css',
      'sass',
      'scss',
      'javascript',
      'typescript',
      'javascriptreact',
      'typescriptreact',
      'svelte',
    },
  },
}
