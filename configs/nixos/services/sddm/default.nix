{
  config,
  pkgs,
  ...
}:
{
  services.displayManager.sddm = {
    wayland.enable = true;
    theme = "where_is_my_sddm_theme";

    extraPackages = with pkgs; [
      kdePackages.qt5compat
      (where-is-my-sddm-theme.override {
        themeConfig.General = with config.scheme.withHashtag; {
          font = config.theme.font.propo;
          helpFont = config.theme.font.propo;

          backgroundFill = base01;
          passwordInputBackground = base00;
          passwordCursorColor = base05;
          passwordTextColor = base05;
          basicTextColor = base05;

          passwordInputWidth = 0.2;

          passwordFontSize = 16;
          sessionsFontSize = 14;
          usersFontSize = 14;
          helpFontSize = 14;

          showSessionsByDefault = true;
          showUsersByDefault = true;
        };
      })
    ];
  };
}
