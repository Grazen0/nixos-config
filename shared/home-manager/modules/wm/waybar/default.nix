{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 32;
        spacing = 4;
        margin-top = 8;
        margin-right = 8;
        margin-left = 8;
        margin-bottom = 0;
        fixed-center = false;

        modules-left = [
          "custom/sysmenu"
          "hyprland/workspaces"
        ];
        modules-center = [
          "hyprland/window"
        ];
        modules-right = [
          "hyprland/submap"
          "hyprland/language"
          "pulseaudio"
          "network"
          "temperature"
          "battery"
          "clock"
          "tray"
          "custom/power"
        ];

        "custom/sysmenu" = {
          format = "";
          tooltip-format = "";
          on-click = "rofi -show drun";
        };

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            default = "";
            active = "";
          };
        };

        "hyprland/window" = {
          format = "{initialTitle}";
          icon = true;
          icon-size = 20;
          separate-outputs = true;
        };

        "hyprland/submap" = {
          format = " {}";
          on-click = "hyprctl dispatch submap reset";
        };

        tray = {
          spacing = 10;
        };

        clock = {
          interval = 1;
          format = "{:%d/%m %H:%M}";
          format-alt = "{:%d/%m/%Y %H:%M:%S}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        temperature = {
          interval = 2;
          # thermal-zone = 2;
          # hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
          critical-threshold = 80;
          format = "{icon} {temperatureC}°C";
          format-icons = ["" "" "" "" ""];
        };

        "hyprland/language" = {
          format = " {short}";
        };

        pulseaudio = {
          scroll-step = 5;
          format = "{icon} {volume}%";
          format-muted = " {volume}%";
          format-icons.default = ["" ""];
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

        network = {
          interval = 1;
          format-wifi = " {bandwidthTotalBytes}";
          format-ethernet = "{ipaddr}/{cidr} ";
          tooltip-format = "{essid}";
          format-disconnected = " Offline";
          on-click = "nm-connection-editor";
        };

        "custom/power" = {
          format = "⏻ ";
          tooltip = false;
          on-click = "rofi -show menu -modi \"menu:rofi-power-menu\"";
        };
      };
    };

    style = ./style.css;
  };
}
