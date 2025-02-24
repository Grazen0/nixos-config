{
  imports = [
    ./plugins.nix
    ./packages.nix
  ];

  xdg.nixConfigFile.nvim.source = ./config;

  programs.neovim = {
    enable = true;

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
  };
}
