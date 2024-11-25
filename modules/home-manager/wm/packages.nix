{pkgs, ...}: {
  home.packages = with pkgs; [
    hyprpicker
    networkmanagerapplet
    polkit_gnome
    rofi-power-menu
    wl-clipboard
    wtype
  ];
}
