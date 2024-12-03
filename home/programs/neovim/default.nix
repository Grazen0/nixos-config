{
  imports = [
    ./plugins.nix
    ./packages.nix
  ];

  xdg.configFile.nvim.source = ./config;

  programs.neovim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;

    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
  };
}
