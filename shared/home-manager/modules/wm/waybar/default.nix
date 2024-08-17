{
  imports = [./scripts.nix];

  programs.waybar = {
    enable = true;
    style = ./style.css;

    settings = {
      mainBar = {
        reload_style_on_change = true;

        layer = "top";
        position = "top";
        height = 32;
        spacing = 4;
        margin-top = 8;
        margin-right = 8;
        margin-left = 8;
        margin-bottom = 0;

        modules-left = [
          "custom/sysmenu"
          "tray"
          "hyprland/language"
          "custom/media"
          "hyprland/submap"
        ];
        modules-center = [
          "hyprland/workspaces"
        ];
        modules-right = [
          "pulseaudio"
          "network"
          "temperature"
          "battery"
          "clock"
          "custom/power"
        ];

        "custom/sysmenu" = {
          format = "";
          tooltip-format = "App launcher";
          on-click = "rofi -show drun";
        };
        tray = {
          spacing = 10;
        };
        "hyprland/language" = {
          format = " {short}";
        };
        "custom/media" = {
          interval = 1;
          format = "{icon}{}";
          format-icons = [""];
          escape = true;
          return-type = "json";
          max-length = 35;
          on-click = "playerctl play-pause";
          on-click-right = "playerctl stop";
          exec = "media-query";
        };
        "hyprland/submap" = {
          format = " {}";
          on-click = "hyprctl dispatch submap reset";
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
          format-ethernet = "{ipaddr}/{cidr} ";
          tooltip-format = "{essid}";
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
          format = " {:%H:%M}";
          format-alt = " {:%d/%m/%y}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };
        "custom/power" = {
          format = "";
          tooltip-format = "Power menu";
          on-click = "rofi -show menu -modi \"menu:rofi-power-menu\"";
        };
      };
    };
  };
}
