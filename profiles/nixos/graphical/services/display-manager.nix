{ config, pkgs, ... }:
{

  environment.systemPackages = [
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

  services = {
    xserver.enable = true;

    displayManager.sddm = {
      enable = true;
      theme = "where_is_my_sddm_theme_qt5";
    };

    greetd = {
      enable = false;
      settings = {
        default_session = {
          command = ''
            ${pkgs.greetd.tuigreet}/bin/tuigreet \
              -r -t --asterisks --remember-user-session \
              -g "Hello there"
          '';
          user = "greeter";
        };
      };
    };

  };
}
