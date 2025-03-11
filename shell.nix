{pkgs ? import <nixpkgs> {}, ...}: rec {
  default = pkgs.mkShellNoCC {
    NIX_CONFIG = "experimental-features = nix-command flakes";
    DIRENV_LOG_FORMAT = "";

    packages = with pkgs; [
      git
      sops
    ];
  };

  iso = default.overrideAttrs (prev: {
    packages = with pkgs;
      [
        qemu
      ]
      ++ (prev.packages or []);
  });
}
