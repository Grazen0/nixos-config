{pkgs, ...}: {
  home.packages = with pkgs; [
    hyprpicker
    networkmanagerapplet
    polkit_gnome
  ];
}
