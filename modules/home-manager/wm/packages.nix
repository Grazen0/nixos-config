{pkgs, ...}: {
  home.packages = with pkgs; [
    dex
    hyprpicker
    networkmanagerapplet
    polkit_gnome
    rofi-power-menu
    wl-clipboard
    wtype
  ];
}
