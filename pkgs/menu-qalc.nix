{
  lib,
  pkgs,
  src,
  ...
}:
# Derivation kinda stolen from https://github.com/NixOS/nixpkgs/blob/master/pkgs/by-name/hy/hyprshot/package.nix
pkgs.stdenvNoCC.mkDerivation {
  pname = "menu-qalc";
  version = "master";
  inherit src;

  nativeBuildInputs = with pkgs; [man makeWrapper];

  installPhase = ''
    runHook preInstall

    install -Dm755 "=" -t "$out/bin"
    wrapProgram "$out/bin/=" \
      --prefix PATH ":" ${lib.makeBinPath (with pkgs; [libqalculate wl-clipboard])}

    install -Dm644 "menu-qalc.1" "=.1" -t "$out/share/man/man1"

    runHook postInstall
  '';

  meta = with lib; {
    description = "A calculator for Wofi/fuzzel/dmenu(2) using libqalculate";
    homepage = "https://github.com/ClemaX/menu-qalc-wayland";
    license = licenses.mit;
    mainProgram = "=";
  };
}
