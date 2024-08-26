{pkgs, ...}: {
  home.packages = with pkgs; [
    bemoji
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
