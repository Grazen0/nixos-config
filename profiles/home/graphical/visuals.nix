{
  config,
  pkgs,
  ...
}: {
  gtk = {
    enable = true;

    theme = {
      name = "Kanagawa-BL";
      package = pkgs.kanagawa-gtk-theme;
    };

    iconTheme = {
      name = "Kanagawa";
      package = pkgs.kanagawa-icon-theme;
    };

    gtk4.extraCss = config.gtk.gtk3.extraCss;
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      font-name = "${config.theme.font.propo} 11";
    };
  };
}
