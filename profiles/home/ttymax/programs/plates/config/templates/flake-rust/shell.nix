{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  inputsFrom = [(pkgs.callPackage ./default.nix {})];

  env = {
    RUST_BACKTRACE = "1";
  };

  buildInputs = with pkgs; [
    rust-analyzer
    rustfmt
    clippy
  ];
}
