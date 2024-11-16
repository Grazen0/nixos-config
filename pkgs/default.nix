{pkgs ? import <nixpkgs> {}, ...}: {
  customScripts = pkgs.callPackage ./custom-scripts {};
  multicursor-nvim = pkgs.callPackage ./multicursor-nvim {};
}
