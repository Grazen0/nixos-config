{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Codeing
    cargo
    cmake
    cling
    gcc
    ghc
    go
    gnumake
    nodejs
    pnpm
    python3
    rustc
    yarn
  ];
}
