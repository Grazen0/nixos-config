{
  config,
  pkgs,
  ...
}:
# lua
''
  vim.loader.enable()

  require('opts')
  require('maps')
  require('autocmds')
  require('user-commands')

  require('lazy').setup({
    performance = {
      reset_packpath = false,
      rtp = { reset = false },
    },
    dev = {
      path = '${pkgs.vimUtils.packDir config.programs.neovim.finalPackage.passthru.packpathDirs}/pack/myNeovimPackages/start',
      patterns = { ''' },
    },
    install = { missing = false },
    change_detection = { enabled = false },
    spec = {
      { import = 'plugins.visuals' },
      { import = 'plugins.editor' },
      { import = 'plugins.lsp' },
      { import = 'plugins.misc' },
    },
  })

  -- Gotta do this again for some reason
  vim.cmd('colorscheme kanagawa')
''
