{pkgs, ...}: {
  home.packages = with pkgs; [
    dex
    grim
    hyprpicker
    networkmanagerapplet
    polkit_gnome
    rofi-power-menu
    slurp
    wl-clipboard
    wtype
  ];
}
