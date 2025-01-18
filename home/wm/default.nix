{
  imports = [
    ./eww
    ./hypr
    ./waybar
    ./cliphist.nix
    ./dunst.nix
    ./fuzzel.nix
    ./wob.nix
  ];

  services.network-manager-applet.enable = true;
}
