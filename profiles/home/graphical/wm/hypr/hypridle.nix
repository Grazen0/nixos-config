{
  config,
  lib',
  pkgs,
  ...
}:
{
  services.hypridle = {
    settings =
      let
        inherit (lib') timeStrToSecs;
        hyprctl = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl";
        hyprlock = "${config.programs.hyprlock.package}/bin/hyprlock";
        brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
      in
      {
        general = {
          lock_cmd = "pidof ${hyprlock} || ${hyprlock}";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "${hyprctl} dispatch dpms on";
        };

        listener = [
          {
            # Reduce monitor brightness
            timeout = timeStrToSecs "5m";
            on-timeout = "${brightnessctl} -s set 15%";
            on-resume = "${brightnessctl} -r";
          }
          {
            # Lock screen
            timeout = timeStrToSecs "10m";
            on-timeout = "loginctl lock-session";
          }
          {
            # Screen off
            timeout = timeStrToSecs "10m 30s";
            on-timeout = "${hyprctl} dispatch dpms off";
            on-resume = "${hyprctl} dispatch dpms on";
          }
          {
            # Suspend
            timeout = timeStrToSecs "30m";
            on-timeout = "systemctl suspend";
          }
        ];
      };
  };
}
