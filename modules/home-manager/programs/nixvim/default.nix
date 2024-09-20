{inputs, ...}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./lsp
    ./plugins
    ./autocmds.nix
    ./base.nix
    ./colorscheme.nix
    ./ftplugin.nix
    ./keymaps.nix
    ./opts.nix
    ./user-commands.nix
  ];
}
