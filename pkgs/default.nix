{pkgs ? import <nixpkgs> {}, ...}: {
  customScripts = pkgs.callPackage ./custom-scripts {};
  aphrodite-terminal-theme = pkgs.callPackage ./aphrodite-terminal-theme {};
  multicursor-nvim = pkgs.callPackage ./multicursor-nvim {};
}
