{pkgs ? import <nixpkgs> {}, ...}: {
  inkscape-figures = pkgs.python312Packages.callPackage ./inkscape-figures.nix {};

  close-window = pkgs.callPackage ./close-window.nix {};
  exe2png = pkgs.callPackage ./exe2png.nix {};
  fuzzel-power-menu = pkgs.callPackage ./fuzzel-power-menu.nix {};
  handle-monitor-connect = pkgs.callPackage ./handle-monitor-connect.nix {};
  make-writable = pkgs.callPackage ./make-writable.nix {};
  volume-update = pkgs.callPackage ./volume-update.nix {};
  waybar-dunst-state = pkgs.callPackage ./waybar-dunst-state.nix {};
  waybar-media-query = pkgs.callPackage ./waybar-media-query.nix {};
}
