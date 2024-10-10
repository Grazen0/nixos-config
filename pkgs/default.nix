{pkgs ? import <nixpkgs> {}, ...}: {
  handle-monitor-connect = pkgs.callPackage ./handle-monitor-connect {};
  aphrodite-terminal-theme = pkgs.callPackage ./aphrodite-terminal-theme {};
  multicursor-nvim = pkgs.callPackage ./multicursor-nvim {};
}
