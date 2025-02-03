{pkgs, ...}: {
  imports = [
    ./cli.nix
    ./graphical.nix
    ./dev.nix
  ];

  home.packages = with pkgs; [
    wine
    (fceux.overrideAttrs (prev: {
      postInstall = ''
        ${prev.postInstall or ""}

        substituteInPlace "$out/share/applications/fceux.desktop" \
          --replace-fail "/usr" "$out"
      '';
    }))
    snes9x-gtk
  ];
}
