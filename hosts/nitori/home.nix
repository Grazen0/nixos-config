{
  lib,
  lib',
  pkgs,
  customPkgs,
  ...
}: let
  inherit (lib) mkForce;
in {
  home.packages = with pkgs; [
    prismlauncher # Minecraft
    polychromatic

    pgadmin
  ];

  wayland.windowManager = {
    hyprland.settings = {
      monitor = [
        ", preferred, auto, 1.2"
        "HDMI-A-1, preferred, auto-left, 1"
      ];

      exec-once = [
        "${customPkgs.handle-monitor-connect}/bin/handle-monitor-connect"
      ];
    };

    river.settings.rule-add."-app-id" = let
      inherit (lib'.river) tagNumStr;
    in {
      "'equibop'" = mkForce ["ssd" "output HDMI-A-1" "tags ${tagNumStr 2}"];
      "'spotify'" = mkForce ["output HDMI-A-1" "tags ${tagNumStr 5}"];
    };
  };

  # Mainly, set 1.2 scale on eDP-1
  services.kanshi.settings = mkForce [
    {
      output = {
        criteria = "eDP-1";
        status = "enable";
        scale = 1.2;
        transform = "normal";
        position = "0,0";
      };
    }
    {
      output = {
        criteria = "HDMI-A-1";
        status = "enable";
        scale = 1.0;
        transform = "normal";
      };
    }
    {
      profile = {
        name = "undocked";
        outputs = [
          {
            criteria = "eDP-1";
          }
        ];
      };
    }
    {
      profile = {
        name = "docked";
        outputs = [
          {
            criteria = "eDP-1";
          }
          {
            criteria = "HDMI-A-1";
            position = "-1920,0";
          }
        ];
      };
    }
  ];

  home.stateVersion = "24.05";
}
