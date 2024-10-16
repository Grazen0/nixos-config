{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    cargo
    cmake
    cling
    clippy
    gcc
    ghc
    gnumake
    nodejs
    pnpm
    (python3.withPackages
      (ps: [
        (ps.callPackage ../../../pkgs/inkscape-figures {})
      ]))
    rustc
  ];
}
