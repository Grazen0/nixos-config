{
  pkgs,
  inputs,
  ...
}: {
  home.packages = let
    inherit (pkgs) system;

    thorium-browser = inputs.thorium-browser.defaultPackage.${system};

    fceux = pkgs.fceux.overrideAttrs (prev: {
      postInstall = ''
        ${prev.postInstall or ""}

        substituteInPlace "$out/share/applications/fceux.desktop" \
          --replace-fail "/usr" "$out"
      '';
    });

    zoomPkgs = import inputs.nixpkgs-zoom {
      inherit system;
      config.allowUnfree = true;
    };
  in
    with pkgs; [
      # Desktop utilities
      pavucontrol
      file-roller
      gimp
      wdisplays

      thorium-browser
      audacity
      inkscape
      # insomnia
      obsidian
      zoomPkgs.zoom-us
      postman

      # Basic gaming
      wine
      fceux
      snes9x-gtk

      # LibreOffice + spellcheck
      libreoffice-qt
      hunspell
      hunspellDicts.en_US
      hunspellDicts.es_PE
    ];
}
