{pkgs, ...}: {
  gtk = rec {
    enable = true;

    theme = {
      name = "Kanagawa-BL";
      package = pkgs.kanagawa-gtk-theme;
    };

    iconTheme = {
      name = "Kanagawa";
      package = pkgs.kanagawa-icon-theme;
    };

    # Disable ugly GTK header on river
    gtk3.extraCss =
      # css
      ''
        /* No (default) title bar on wayland */
        headerbar.default-decoration {
          /* You may need to tweak these values depending on your GTK theme */
          margin-bottom: 50px;
          margin-top: -100px;
        }

        /* rm -rf window shadows */
        window.csd,             /* gtk4? */
        window.csd decoration { /* gtk3 */
          box-shadow: none;
        }
      '';

    gtk4.extraCss = gtk3.extraCss;
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
  };
}
