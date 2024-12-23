{
  pkgs,
  customPkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    cargo
    cling
    clippy
    gcc
    ghc
    gnumake
    jdk
    nodejs_22
    corepack_22
    (python312.withPackages
      (pyPkgs: [
        customPkgs.inkscape-figures
      ]))
    rustc
  ];
}
