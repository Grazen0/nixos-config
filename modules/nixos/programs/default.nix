{lib, ...}: {
  imports = [
    ./thunar.nix
  ];

  programs = {
    dconf.enable = true;
    hyprland.enable = true;
    steam.enable = lib.mkDefault true;
  };
}
