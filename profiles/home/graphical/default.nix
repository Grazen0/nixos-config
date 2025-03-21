{
  config,
  pkgs,
  customPkgs,
  ...
}: {
  imports = [
    ../ttymax
    ./programs
    ./wm
    ./packages.nix
    ./visuals.nix
    ./xdg.nix
  ];

  meta.mainPrograms = let
    inherit (config) programs;
  in {
    terminal = "${programs.foot.package}/bin/foot";
    browser = "zen";
    fileManager = "thunar";
    appLauncher = "${programs.fuzzel.package}/bin/fuzzel";
    dmenu = "${programs.fuzzel.package}/bin/fuzzel --dmenu";
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
