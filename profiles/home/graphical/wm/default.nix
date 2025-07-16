{ pkgs, ... }:
{
  imports = [
    ./eww
    ./hypr
    ./river
    ./sway
    ./waybar
    ./wlogout
    ./cliphist.nix
    ./dunst.nix
    ./env.nix
    ./fnott.nix
    ./fuzzel.nix
    ./kanshi.nix
    ./rofi.nix
    ./wob.nix
  ];

  home.packages = with pkgs; [ networkmanagerapplet ];
}
