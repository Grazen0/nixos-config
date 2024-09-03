{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    cargo
    cmake
    cling
    gcc
    ghc
    go
    gnumake
    nodejs
    pnpm
    (python3.withPackages
      (ps:
        with ps; [
          (ps.callPackage ../../../pkgs/inkscape-figures {})
        ]))
    rustc
    yarn
  ];
}
