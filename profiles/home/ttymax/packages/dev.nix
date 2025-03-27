{pkgs, ...}: {
  home.packages = with pkgs; [
    gcc
    cmake
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
