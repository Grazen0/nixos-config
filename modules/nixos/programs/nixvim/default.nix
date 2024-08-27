{inputs, ...}: {
  imports = [
    inputs.nixvim.nixosModules.nixvim
    ./lsp
    ./plugins
    ./autocmds.nix
    ./colorscheme.nix
    ./ftplugin.nix
    ./keymaps.nix
    ./opts.nix
    ./user-commands.nix
  ];

  programs.nixvim = {
    enable = true;

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    wrapRc = true;
  };
}
