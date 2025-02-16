{
  pkgs,
  inputs,
  ...
}: {
  home.packages = let
    inherit (pkgs) system;

    thorium-browser = inputs.thorium-browser.defaultPackage.${system};

    zen-browser = inputs.zen-browser.packages.${system}.specific.overrideAttrs (prev: let
      version = "1.7b";
    in {
      inherit version;
      src = builtins.fetchTarball {
        url = "https://github.com/zen-browser/desktop/releases/download/${version}/zen.linux-x86_64.tar.bz2";
        sha256 = "sha256:0aig890fcynxwi7xi8jzd1w2gzg47n0jqfq76wvnkwcam611b2bp";
      };
    });

    # Insomnia but with Wayland flags
    # Thanks to https://github.com/NixOS/nixpkgs/issues/345717
    insomnia = pkgs.insomnia.override (prev: {
      appimageTools =
        prev.appimageTools
        // {
          wrapType2 = prevArgs:
            prev.appimageTools.wrapType2 (prevArgs
              // {
                extraInstallCommands =
                  # bash
                  ''
                    ${prevArgs.extraInstallCommands}

                    substituteInPlace $out/share/applications/insomnia.desktop \
                      --replace-fail 'Exec=insomnia' 'Exec=insomnia --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform=wayland'
                  '';
              });
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
      insomnia
      obsidian
      pavucontrol
      thorium-browser
      steam-run
      zen-browser
      zoomPkgs.zoom-us

      # LibreOffice + spellcheck
      libreoffice-qt
      hunspell
      hunspellDicts.en_US
      hunspellDicts.es_PE
    ];
}
