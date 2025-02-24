{
  pkgs,
  customPkgs,
  ...
}: {
  home.packages = with pkgs; [
    gcc
    cling

    gnumake
    cargo
    rustc
    clippy

    ghc

    jdk

    nodejs
    pnpm

    (python3.withPackages (ps:
      with ps; [
        customPkgs.inkscape-figures
      ]))
  ];
}
