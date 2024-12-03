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
    nodejs_22
    pnpm
    (python312.withPackages
      (pyPkgs: [
        customPkgs.inkscape-figures
      ]))
    rustc
  ];
}
