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

    nodejs_22
    corepack_22

    (python3.withPackages (ps:
      with ps; [
        customPkgs.inkscape-figures
      ]))
  ];
}
