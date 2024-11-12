{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    cargo
    cling
    clippy
    gcc
    ghc
    gnumake
    nodejs_22
    pnpm
    (python313.withPackages
      (ps: [
        (ps.callPackage ../../../pkgs/inkscape-figures {})
      ]))
    rustc
  ];
}
