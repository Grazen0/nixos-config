{
  pkgs ? import <nixpkgs> { },
}:
pkgs.mkShell {
  name = "nixos-dev";

  env = {
    NIX_CONFIG = "experimental-features = nix-command flakes";
    DIRENV_LOG_FORMAT = "";
  };

  packages = with pkgs; [
    git
  ];
}
