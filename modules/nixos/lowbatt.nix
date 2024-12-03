{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.services.lowbatt;
in {
  options.services.lowbatt = let
    inherit (lib) mkEnableOption mkOption types;
  in {
    enable = mkEnableOption "lowbatt";

    action = mkOption {
      type = types.enum ["suspend" "hibernate"];
      description = ''
        Action to perform when at critical level.
      '';
      default = "suspend";
    };

    device = mkOption {
      type = types.str;
      description = ''
        Device to monitor.
      '';
      default = "BAT0";
    };

    notifyCapacity = mkOption {
      type = types.ints.between 0 100;
      default = 15;
      description = ''
        Battery level at which to send a notification if discharging.
      '';
    };

    suspendCapacity = mkOption {
      type = types.ints.between 0 100;
      default = 5;
      description = ''
        Battery level at which to suspend if discharging.
      '';
    };

    notifications = {
      notify = {
        title = mkOption {
          type = types.str;
          default = "Battery is low";
        };

        body = mkOption {
          type = types.str;
          default = "You should probably plug in your charger.";
        };
      };

      suspend = {
        title = mkOption {
          type = types.str;
          default = "Battery is critically low";
        };

        body = mkOption {
          type = types.str;
          default = ''
            Computer will suspend in 60 seconds.
            You should plug in your charger, NOW!!!
          '';
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    # Credit: https://gist.github.com/domenkozar/82886ee82efee623cdc0d19eb81c7fb7
    systemd.user = {
      timers."lowbatt" = {
        description = "Check battery level";
        timerConfig = {
          OnBootSec = "30s";
          OnUnitInactiveSec = "30s";
          Unit = "lowbatt.service";
        };
        wantedBy = ["timers.target"];
      };

      services."lowbatt" = {
        description = "Battery level notifier";
        serviceConfig.PassEnvironment = "DISPLAY";
        script = let
          inherit (cfg) device suspendCapacity notifyCapacity;
          inherit (cfg.notifications) notify suspend;
          inherit (lib.strings) escapeShellArgs;

          notify-send = "${pkgs.libnotify}/bin/notify-send";
        in
          # bash
          ''
            capacity=$(cat /sys/class/power_supply/${device}/capacity)
            status=$(cat /sys/class/power_supply/${device}/status)

            if [[ "$status" == "Discharging" ]]; then
              if [[ "$capacity" -le ${toString suspendCapacity} ]]; then
                  ${notify-send} -u critical -h int:transient:1 ${escapeShellArgs [suspend.title suspend.body]}
                  sleep 60s

                  new_status=$(cat /sys/class/power_supply/${device}/status)
                  [[ "$new_status" == "Discharging" ]] && systemctl ${cfg.action}
              elif [[ $capacity -le ${toString notifyCapacity} ]]; then
                  ${notify-send} -u critical -h int:transient:1 ${escapeShellArgs [notify.title notify.body]}
              fi
            fi

          '';
      };
    };
  };
}
