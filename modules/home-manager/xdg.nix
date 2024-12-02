{
  config,
  lib,
  pkgs,
  ...
}: {
  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;

      publicShare = "${config.xdg.dataHome}/public";
      templates = "${config.xdg.dataHome}/templates";

      extraConfig = {
        XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/Screenshots";
        XDG_CODE_DIR = "${config.home.homeDirectory}/Code";
        XDG_GAMES_DIR = "${config.home.homeDirectory}/Games";
      };
    };

    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
      ];
      config.common.default = "*";
    };

    dataFile = let
      mkTouhou = {
        game,
        fullName,
        path ? "${config.home.homeDirectory}/Games/Touhou ${game}",
        exec ? null,
      }: let
        paddedGame = lib.strings.fixedWidthString 2 "0" game;
        actualExec =
          if isNull exec
          then "th${paddedGame} (thpatch-en).exe"
          else exec;
      in {
        "applications/th${paddedGame}.desktop".text = ''
          [Desktop Entry]
          Type=Application
          Name=Touhou ${game} - ${fullName}
          GenericName=Touhou ${game}
          Path=${path}
          Exec=${pkgs.wine}/bin/wine '${actualExec}'
          Icon=${../../files/touhou/th${paddedGame}.png}
        '';
      };
    in
      mkTouhou {
        game = "6";
        fullName = "The Embodiment of Scarlet Devil";
      }
      // mkTouhou {
        game = "7";
        fullName = "Perfect Cherry Blossom";
      }
      // mkTouhou {
        game = "8";
        fullName = "Imperishable Night";
      }
      // mkTouhou
      {
        game = "10";
        fullName = "Mountain of Faith";
      }
      // mkTouhou {
        game = "11";
        fullName = "Subterranean Animism";
      };

    mimeApps = {
      enable = true;

      defaultApplications = let
        browser = ["zen.desktop"];
        documentViewer = ["org.pwmt.zathura.desktop"];
        fileManager = ["thunar.desktop"];
        archiver = ["org.gnome.FileRoller.desktop"];
        editor = ["nvim.desktop"];
        imageViewer = ["swayimg.desktop"];
        mediaPlayer = ["mpv.desktop"];

        inherit (lib.attrsets) mapAttrsToList genAttrs;
        inherit (lib.strings) splitString hasPrefix;

        globAssociations = {
          "audio/" = mediaPlayer;
          "video/" = mediaPlayer;
          "image/" = imageViewer;
          "text/" = editor;
        };

        commonTypes = splitString "\n" (lib.readFile "${pkgs.shared-mime-info}/share/mime/types");
        expandedAssociations = lib.mergeAttrsList (mapAttrsToList (name: value: genAttrs (lib.filter (hasPrefix name) commonTypes) (_: value)) globAssociations);
      in
        {
          "x-scheme-handler/http" = browser;
          "x-scheme-handler/https" = browser;
          "x-scheme-handler/chrome" = browser;
          "x-scheme-handler/webcal" = browser;
          "x-scheme-handler/ftp" = browser;
          "x-scheme-handler/about" = browser;
          "x-scheme-handler/unknown" = browser;
          "application/x-extension-htm" = browser;
          "application/x-extension-html" = browser;
          "application/x-extension-shtml" = browser;
          "application/xhtml+xml" = browser;
          "application/x-extension-xhtml" = browser;
          "application/x-extension-xht" = browser;
          "application/json" = browser;

          "application/pdf" = documentViewer;

          "inode/directory" = fileManager;

          "application/zip" = archiver;

          "application/x-zerosize" = editor;
        }
        // expandedAssociations;
    };
  };
}
