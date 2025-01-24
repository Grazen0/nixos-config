{
  config,
  pkgs,
  ...
}: {
  services.hypridle = {
    enable = true;

    settings = let
      hyprctl = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl";
      hyprlock = "${config.programs.hyprlock.package}/bin/hyprlock";
      brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
    in {
      general = {
        lock_cmd = "pidof ${hyprlock} || ${hyprlock}";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "${hyprctl} dispatch dpms on";
      };

      listener = [
        {
          # Reduce monitor brightness after 5m
          timeout = 300;
          on-timeout = "${brightnessctl} -s set 15%";
          on-resume = "${brightnessctl} -r";
        }
        {
          # Lock screen after 10m
          timeout = 600;
          on-timeout = "loginctl lock-session";
        }
        {
          # Screen off after 10m 30s
          timeout = 630;
          on-timeout = "${hyprctl} dispatch dpms off";
          on-resume = "${hyprctl} dispatch dpms on";
        }
        {
          # Suspend after 30m
          timeout = 1800;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
