{
  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
    };

    mimeApps = {
      enable = true;

      defaultApplications = {
        "x-scheme-handler/webcal" = "brave-browser.desktop";
        "x-scheme-handler/http" = "brave-browser.desktop";
        "x-scheme-handler/https" = "brave-browser.desktop";

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
