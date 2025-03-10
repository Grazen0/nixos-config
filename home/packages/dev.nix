{
  pkgs,
  customPkgs,
  ...
}: {
  home.packages = with pkgs; [
    gcc
    gnumake
    cargo
    rustc
    clippy
    (haskellPackages.ghcWithPackages (ps:
      with ps; [
        stack
      ]))
    jdk
    nodejs
    pnpm

    (python3.withPackages (ps:
      with ps; [
        customPkgs.inkscape-figures
      ]))
  ];
}
