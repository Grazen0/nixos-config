{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.services.displayManager) sddm;
in
{
  services.xserver = lib.mkIf sddm.enable {
    enable = true;
  };

  environment.systemPackages = lib.optionals sddm.enable [
    (pkgs.where-is-my-sddm-theme.override {
      variants = [ "qt5" ];
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

  services.displayManager.sddm = {
    theme = "where_is_my_sddm_theme_qt5";
  };
}
