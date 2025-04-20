{
  pkgs ? import <nixpkgs> { },
  ...
}:
rec {
  default = pkgs.mkShellNoCC {
    name = "nixos-dev";

    env = {
      NIX_CONFIG = "experimental-features = nix-command flakes";
      DIRENV_LOG_FORMAT = "";
    };

    packages = with pkgs; [
      git
      sops

      nixfmt-rfc-style
      deadnix
      nil
      nh
      nix-diff
      nix-tree
    ];
  };

  iso = default.overrideAttrs (prev: {
    name = "nixos-dev-iso";

    packages = with pkgs; [ qemu ] ++ (prev.packages or [ ]);
  });
}
