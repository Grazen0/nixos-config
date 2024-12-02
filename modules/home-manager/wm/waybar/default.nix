{
  config,
  lib,
  pkgs,
  customPkgs,
  ...
}: {
  programs.waybar = {
    enable = true;

    style = let
      inherit (config) theme;
    in
      with theme.colors.hexWithHashtag; ''
        @define-color black ${black};
        @define-color bright-black ${brightBlack};
        @define-color red ${red};
        @define-color green ${green};
        @define-color yellow ${yellow};
        @define-color blue ${blue};
        @define-color magenta ${magenta};
        @define-color cyan ${cyan};
        @define-color white ${white};
        @define-color bright-white ${brightWhite};

        @define-color background ${background};
        @define-color foreground ${foreground};

        * {
          font-family: ${theme.font.propo}, monospace;
        }

        ${lib.readFile ./style.css}
      '';

    settings = {
      mainBar = {
        reload_style_on_change = true;

        layer = "top";
        position = "top";
        height = 36;
        spacing = 0;

        modules-left = [
          "custom/sysmenu"
          "tray"
          "hyprland/language"
          "custom/media"
        ];

        modules-center = ["hyprland/workspaces"];

        modules-right = [
          "pulseaudio"
          "network"
          "temperature"
          "battery"
          "clock"
          "custom/notifications"
          "custom/power"
        ];

        "custom/sysmenu" = {
          format = "";
          tooltip-format = "App launcher";
          on-click = "${pkgs.fuzzel}/bin/fuzzel";
        };

        tray = {
          spacing = 10;
        };

        "hyprland/language" = {
          format = " {short}";
        };

        "custom/media" = let
          playerctl = "${pkgs.playerctl}/bin/playerctl";
        in {
          interval = 1;
          format = "{icon}{}";
          format-icons = [""];
          escape = true;
          return-type = "json";
          max-length = 35;
          on-click = "${playerctl} play-pause";
          on-click-right = "${playerctl} stop";
          exec = "${customPkgs.waybar-media-query}/bin/media-query";
        };

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            default = "";
            active = "";
            urgent = "";
          };
        };

        pulseaudio = {
          scroll-step = 5;
          format = "{icon} {volume}%";
          format-muted = " {volume}%";
          format-icons.default = ["" ""];
          on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
        };

        network = {
          interval = 1;
          format-wifi = " {bandwidthTotalBytes}";
          format-ethernet = " {bandwidthTotalBytes}";
          tooltip-format = "{essid} ({signalStrength}%)";
          format-disconnected = " Offline";
          on-click = "nm-connection-editor";
        };

        temperature = {
          interval = 2;
          # thermal-zone = 2;
          # hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
          critical-threshold = 80;
          format = "{icon} {temperatureC}°C";
          format-icons = ["" "" "" "" ""];
        };

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
          dunstctl = "${pkgs.dunst}/bin/dunstctl";
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
