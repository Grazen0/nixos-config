{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./packages
    ./programs
    ./wm
    ./looks.nix
    ./home.nix
    ./xdg.nix
    ./zsh.nix
  ];

  home = {
    username = "jdgt";
    homeDirectory = "/home/${config.home.username}";
  };

  theme.home = {
    wallpaper = {
      enable = true;
      source = ../files/wallpaper.png;
    };

    cursor = {
      enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };
  };

  nixpkgs.config = import ./nixpkgs-config.nix;
  xdg.configFile."nixpkgs/config.nix".source = ./nixpkgs-config.nix;
}
