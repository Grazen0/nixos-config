{
  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
    };

    mimeApps = {
      enable = true;

      defaultApplications = let
        browser = "userapp-Zen Browser-I1KWS2.desktop";
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
