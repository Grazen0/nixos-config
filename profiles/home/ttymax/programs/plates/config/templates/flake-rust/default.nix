{
  lib,
  rustPlatform,
  installShellFiles,
  ...
}: let
  manifest = (lib.importTOML ./Cargo.toml).package;
  inherit (manifest) name;
in
  rustPlatform.buildRustPackage rec {
    pname = name;
    inherit (manifest) version;
    src = lib.cleanSource ./.;
    cargoLock.lockFile = "${src}/Cargo.lock";

    env = {
      RUST_BACKTRACE = "1";
    };

    nativeBuildInputs = [
      installShellFiles
    ];

    # meta = with lib; {
    #   description = "{{ description }}";
    #   homepage = manifest.homepage;
    #   license = licenses.mit;
    #   mainProgram = "TODO";
    # };
  }
