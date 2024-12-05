{pkgs, ...}: {
  imports = [
    ./eww
    ./hypr
    ./waybar
    ./cliphist.nix
    ./dunst.nix
    ./fuzzel.nix
    ./wob.nix
  ];

  home.packages = with pkgs; [
    networkmanagerapplet
    polkit_gnome
  ];
}
