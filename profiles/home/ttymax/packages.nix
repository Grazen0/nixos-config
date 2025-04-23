{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gcc
    cmake
    gnumake
    cargo
    rustc
    clippy
    (haskellPackages.ghcWithPackages (ps: with ps; [ stack ]))
    nodejs
    pnpm
    python3

    pciutils
    nitch
  ];
}
