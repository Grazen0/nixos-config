{lib, ...}: {
  imports = [
    ./thunar.nix
  ];

  programs = {
    dconf.enable = true;
    hyprland.enable = true;
    river.enable = true;
    steam.enable = lib.mkDefault true;
  };
}
