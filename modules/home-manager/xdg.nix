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
          Exec='${actualExec}'
          Icon=${path}/th${paddedGame}.png
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
        browser = "zen.desktop";
      in {
        "x-scheme-handler/http" = browser;
        "x-scheme-handler/https" = browser;
        "x-scheme-handler/chrome" = browser;
        "x-scheme-handler/webcal" = browser;
        "text/html" = browser;
        "application/x-extension-htm" = browser;
        "application/x-extension-html" = browser;
        "application/x-extension-shtml" = browser;
        "application/xhtml+xml" = browser;
        "application/x-extension-xhtml" = browser;
        "application/x-extension-xht" = browser;

        "inode/directory" = "thunar.desktop";

        "application/x-zerosize" = "nvim.desktop";
        "text/plain" = "nvim.desktop";

        "application/pdf" = "org.pwmt.zathura.desktop";

        "image/png" = "nsxiv.desktop";
        "image/jpeg" = "nsxiv.desktop";
        "image/gif" = "nsxiv.desktop";
      };
    };
  };
}
