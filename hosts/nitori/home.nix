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

    river.settings.rule-add = let
      inherit (lib'.river) tagNum;
    in {
      "'equibop'" = mkForce ["ssd" "output HDMI-A-1" "tags ${toString (tagNum 2)}"];
      "'spotify'" = mkForce ["output HDMI-A-1" "tags ${toString (tagNum 5)}"];
    };
  };

  # Set 1.2 scale on main monitor
  services.kanshi.profiles.dualMonitor.outputs = mkForce [
    {
      criteria = "eDP-1";
      status = "enable";
      scale = 1.2;
      position = "0,0";
      transform = "normal";
    }
    {
      criteria = "HDMI-A-1";
      status = "enable";
      scale = 1.0;
      position = "-1366,0";
      transform = "normal";
    }
  ];

  home.stateVersion = "24.05";
}
