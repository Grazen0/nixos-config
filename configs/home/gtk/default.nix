{ config, pkgs, ... }:
{
  gtk = {
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
}
