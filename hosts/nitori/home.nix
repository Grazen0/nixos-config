{
  lib,
  lib',
  pkgs,
  customPkgs,
  ...
}:
let
  inherit (lib) mkForce;
in
{
  imports = [
    ../../options/common
    ../../options/home-manager
    ../../configs/home

    ../../components/common/theme
    ../../components/home/base
    ../../components/home/graphical
    ../../components/home/touhou
    ../../components/home/tty
  ];

  home.packages = with pkgs; [
    kdePackages.kdenlive
    prismlauncher
    osu-lazer
  ];

  wayland.windowManager = {
    hyprland.settings = {
      monitor = mkForce [
        ", preferred, auto, 1.2"
        "HDMI-A-1, preferred, auto-left, 1"
      ];

      exec-once = [ "${customPkgs.handle-monitor-connect}/bin/handle-monitor-connect" ];
    };

    river.settings.rule-add =
      let
        inherit (lib'.river) tagNumStr;
      in
      {
        "-app-id" = {
          "'equibop'" = mkForce [
            "output HDMI-A-1"
            "tags ${tagNumStr 2}"
          ];
        };
      };
  };

  meta.eww = {
    battery = "BAT1";

    outputs = {
      primary = "AUOptronics";
      secondary = "SamsungElectricCompany";
    };
  };

  # Mainly, set scale on eDP-1
  services.kanshi.settings = mkForce [
    {
      output = {
        criteria = "eDP-1";
        status = "enable";
        scale = 1.25;
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
        position = "-1366,0";
      };
    }
    {
      profile = {
        name = "undocked";
        outputs = [ { criteria = "eDP-1"; } ];
      };
    }
    {
      profile = {
        name = "docked";
        outputs = [
          { criteria = "eDP-1"; }
          { criteria = "HDMI-A-1"; }
        ];
      };
    }
  ];

  home.stateVersion = "24.05";
}
