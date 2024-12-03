{pkgs ? import <nixpkgs> {}, ...}: {
  default = pkgs.mkShellNoCC {
    NIX_CONFIG = "experimental-features = nix-command flakes";
    packages = with pkgs; [git];
  };
}
