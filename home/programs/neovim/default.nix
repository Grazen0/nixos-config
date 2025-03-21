{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./plugins.nix
    ./packages.nix
  ];

  xdg.nixConfigFile.nvim.source = ./config;

  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
  };
}
