{
  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
    };

    mimeApps = {
      enable = true;

      defaultApplications = {
        "x-scheme-handler/webcal" = "librewolf.desktop";
        "x-scheme-handler/http" = "librewolf.desktop";
        "x-scheme-handler/https" = "librewolf.desktop";

        "inode/directory" = "pcmanfm-qt.desktop";

        "application/pdf" = "org.pwmt.zathura.desktop";

        "image/png" = "nsxiv.desktop";
        "image/jpeg" = "nsxiv.desktop";
        "image/gif" = "nsxiv.desktop";
      };
    };
  };
}
