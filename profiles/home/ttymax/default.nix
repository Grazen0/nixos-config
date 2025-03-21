{pkgs, ...}: {
  imports = [
    ../minimal
    ../../../components/common/theme
    ./programs
  ];

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
    python3
  ];
}
