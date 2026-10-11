{
  config,
  pkgs,
  stablePkgs,
  ...
}:
{
  gtk = {
    theme = {
      name = "Kanagawa-BL";
      package = stablePkgs.kanagawa-gtk-theme;
    };

    iconTheme = {
      name = "Kanagawa";
      package = pkgs.kanagawa-icon-theme;
    };

    gtk4.extraCss = config.gtk.gtk3.extraCss;
    gtk4.theme = config.gtk.theme;
  };
}
