{
  pkgs,
  stablePkgs,
  inputs,
  ...
}: {
  home.packages = let
    inherit (pkgs) system;
    thorium-browser = inputs.thorium-browser.defaultPackage.${system};

    zen-browser = inputs.zen-browser.packages.${system}.specific.overrideAttrs (prev: let
      version = "1.0.1-a.22";
    in {
      inherit version;
      src = builtins.fetchTarball {
        url = "https://github.com/zen-browser/desktop/releases/download/${version}/zen.linux-specific.tar.bz2";
        sha256 = "sha256:0anr79rdm62h5y37xa47rrrk32r9gnv04df4z7brc0hp4q83pxvi";
      };
    });

    zoomPkgs = import inputs.nixpkgs-zoom {
      inherit system;
      config.allowUnfree = true;
    };
  in
    with pkgs; [
      # Apps
      file-roller
      gimp
      inkscape
      kdenlive
      obsidian
      pavucontrol
      thorium-browser
      wdisplays
      zen-browser
      zoomPkgs.zoom-us

      # LibreOffice + spellcheck
      libreoffice-qt
      hunspell
      hunspellDicts.en_US
      hunspellDicts.es_PE
    ];
}
