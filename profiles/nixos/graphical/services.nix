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

        passwordFontSize = 14;
        sessionsFontSize = 14;
        usersFontSize = 14;
        helpFontSize = 14;

        showSessionsByDefault = true;
        showUsersByDefault = true;
      };
    })
  ];

  services = {
    blueman.enable = true;
    printing.enable = true;
    libinput.enable = true;
    gvfs.enable = true;
    tumbler.enable = true;

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

    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;

      configPackages = [
        # Credit: https://discourse.nixos.org/t/pipewire-selects-msbc-by-default/46728
        (pkgs.writeTextDir "share/wireplumber/bluetooth.lua.d/51-bluez-config.lua" ''
          bluez_monitor.properties = {
            ["bluez5.enable-sbc-xq"] = true,
            ["bluez5.enable-msbc"] = true,
            ["bluez5.enable-hw-volume"] = true,
            ["bluez5.roles"] = "[ a2dp_sink a2dp_source bap_sink bap_source hsp_hs hsp_ag hfp_hf hfp_ag ]"
          }
        '')
      ];
    };
  };
}
