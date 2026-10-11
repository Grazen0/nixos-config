{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.displayManager.sddm;
in
{
  environment.systemPackages = lib.optionals cfg.enable (
    with pkgs;
    [
      # maybe i can move this to extraPackages
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
    ]
  );

  services.displayManager.sddm = {
    wayland.enable = cfg.enable;
    theme = "where_is_my_sddm_theme";

    extraPackages = with pkgs; [
      kdePackages.qt5compat
    ];
  };
}
