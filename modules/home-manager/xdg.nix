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

      publicShare = "${config.home.homeDirectory}/.local/share/public";
      templates = "${config.home.homeDirectory}/.local/share/templates";

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
        archiver = ["org.kde.ark.desktop"];
        editor = ["nvim.desktop"];
        imageViewer = ["swayimg.desktop"];
        mediaPlayer = ["mpv.desktop"];
      in {
        "text/html" = browser;
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

        "inode/directory" = fileManager;

        "application/zip" = archiver;
        "application/json" = browser;
        "application/pdf" = documentViewer;
        "application/x-zerosize" = editor;

        "audio/*" = mediaPlayer;
        "video/*" = mediaPlayer;
        "image/*" = imageViewer;
        "text/*" = editor;
      };
    };
  };
}
