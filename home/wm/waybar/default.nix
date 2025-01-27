{
  config,
  lib,
  pkgs,
  lib',
  customPkgs,
  ...
}: {
  programs.waybar = {
    enable = true;

    style = let
      inherit (config) theme;

      colorDefinitions =
        lib.mapAttrsToList (name: value: "@define-color ${lib'.strings.camelToKebab name} ${value};")
        theme.colors.hexWithHashtag;
    in
      # css
      ''
        * {
          font-family: ${theme.font.propo}, monospace;
        }

        ${lib.concatLines colorDefinitions}
        ${lib.readFile ./style.css}
      '';

    settings = {
      mainBar = {
        reload_style_on_change = true;

        layer = "top";
        position = "top";
        height = 28;
        spacing = 0; # I prefer to use CSS margin

        modules-left = [
          "custom/sysmenu"
          "tray"
          # "custom/language" # foo=$(setxkbmap -query | grep layout | awk '{print $2}')
          "custom/media"
        ];

        modules-center = ["river/tags"];

        modules-right = [
          "pulseaudio"
          "network"
          # "temperature"
          "battery"
          "clock"
          "custom/notifications"
          "custom/power"
        ];

        "custom/sysmenu" = {
          format = "";
          tooltip-format = "App launcher";
          on-click = config.mainPrograms.appLauncher;
        };

        tray = {
          spacing = 10;
        };

        "custom/media" = let
          playerctl = "${pkgs.playerctl}/bin/playerctl";
        in {
          interval = 1;
          format = "{}";
          escape = true;
          return-type = "json";
          max-length = 35;
          on-click = "${playerctl} play-pause";
          exec = "${customPkgs.waybar-media-query}/bin/media-query";
        };

        "river/tags" = {
          num-tags = 9;
        };

        pulseaudio = {
          scroll-step = 5;
          format = "{icon} {volume}%";
          format-muted = " {volume}%";
          format-icons.default = ["" ""];
          on-click = "${pkgs.pamixer}/bin/pamixer -t && ${customPkgs.volume-update}/bin/volume-update";
        };

        network = {
          interval = 1;
          format-wifi = " {bandwidthTotalBytes}";
          format-ethernet = " {bandwidthTotalBytes}";
          tooltip-format = "{essid} ({signalStrength}%)";
          format-disconnected = " Offline";
          on-click = "nm-connection-editor";
        };

        # temperature = {
        #   interval = 2;
        #   thermal-zone = 3;
        #   # hwmon-path = "/sys/devices/platform/coretemp.0/hwmon/hwmon4/temp2_input";
        #   critical-threshold = 80;
        #   format = "{icon} {temperatureC}°C";
        #   format-icons = ["" "" "" "" ""];
        # };

        battery = {
          interval = 5;
          full-at = 97;

          states = {
            warning = 30;
            critical = 15;
          };

          format = "{icon} {capacity}%";
          format-full = " {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-icons = ["" "" "" "" ""];
        };

        clock = {
          interval = 1;
          format = " {:%I:%M %p}";
          format-alt = " {:%d/%m/%y}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        "custom/notifications" = let
          dunstctl = "${config.services.dunst.package}/bin/dunstctl";
          signal = 3; # Workaround since exec-on-event isn't guaranteed
        in {
          exec = "${customPkgs.waybar-dunst-state}/bin/dunst-state";
          escape = true;
          return-type = "json";
          exec-on-event = false;
          on-click = "${dunstctl} set-paused toggle && pkill -SIGRTMIN+${toString signal} waybar";
          tooltip-format = "Toggle notifications";
          inherit signal;
        };

        "custom/power" = {
          format = "";
          tooltip-format = "Power menu";
          on-click = "${customPkgs.fuzzel-power-menu}/bin/fuzzel-power-menu";
        };
      };
    };
  };
}
