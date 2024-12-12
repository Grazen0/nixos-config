{
  pkgs,
  inputs,
  ...
}: {
  home.packages = let
    inherit (pkgs) system;

    thorium-browser = inputs.thorium-browser.defaultPackage.${system};

    zen-browser = inputs.zen-browser.packages.${system}.specific.overrideAttrs (prev: let
      version = "1.0.2-b.1";
    in {
      inherit version;
      src = builtins.fetchTarball {
        url = "https://github.com/zen-browser/desktop/releases/download/${version}/zen.linux-specific.tar.bz2";
        sha256 = "sha256:1bnalbpzk6alihjsvl9nmzn7zfy9a3dcil8dbrlbfz68jiz88hl1";
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
