{pkgs, ...}: {
  home.packages = with pkgs; [
    networkmanagerapplet
    polkit_gnome
  ];
}
