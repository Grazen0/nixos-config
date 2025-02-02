{
  imports = [
    ./plugins.nix
    ./packages.nix
  ];

  xdg.configFile.nvim = {
    source = ./config;
    recursive = true; # Neovim might try to write stuff here
  };

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
