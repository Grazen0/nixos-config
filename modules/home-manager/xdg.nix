{pkgs, ...}: {
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
