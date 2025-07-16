{ pkgs, customPkgs, ... }:
{
  imports = [
    ../ttymax
    ./programs
    ./wm
    ./packages.nix
    ./visuals.nix
    ./xdg.nix
  ];

  meta.mainPrograms = {
    terminal = "foot";
    browser = "firefox";
    fileManager = "thunar";
    appLauncher = "rofi -show drun";
    dmenu = "rofi -dmenu";
  };

  home.packages = with pkgs; [
    customPkgs.make-writable
    cryptsetup
    rmtrash
    trash-cli
  ];

  theme.home = {
    wallpaper = {
      enable = true;
      source = ./wallpaper.png;
    };

    cursor = {
      enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };
  };
}
