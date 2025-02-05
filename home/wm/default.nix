{pkgs, ...}: {
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
    ./fuzzel.nix
    ./kanshi.nix
    ./main-programs.nix
    ./wob.nix
  ];

  home.packages = with pkgs; [
    networkmanagerapplet
  ];
}
