{
  config,
  pkgs,
  customPkgs,
  ...
}@moduleArgs:
{
  programs.waybar = {
    style = (import ./style.nix) moduleArgs;

    settings = {
      mainBar = {
        reload_style_on_change = true;

        layer = "bottom";
        position = "top";
        height = 28;
        spacing = 0; # I prefer to use CSS margin

        modules-left = [
          "custom/sysmenu"
          "tray"
          "custom/media"
        ];

        modules-center = [ "hyprland/workspaces" ];

        modules-right = [
          "pulseaudio"
          "memory"
          "network"
          "battery"
          "clock"
          "custom/notifications"
          "custom/power"
        ];

        "custom/sysmenu" = {
          format = " ";
          tooltip-format = "App launcher";
          on-click = config.meta.mainPrograms.appLauncher;
        };

        tray = {
          spacing = 10;
        };

        "custom/media" =
          let
            playerctl = "${pkgs.playerctl}/bin/playerctl -p mopidy,spotify";
            media-query = "${customPkgs.waybar-media-query}/bin/media-query";
          in
          {
            interval = 1;
            format = "{}";
            escape = true;
            return-type = "json";
            max-length = 35;
            on-click = "${playerctl} play-pause";
            exec = media-query;
          };

        pulseaudio =
          let
            pamixer = "${pkgs.pamixer}/bin/pamixer";
            volume-update = "${customPkgs.volume-update}/bin/volume-update";
          in
          {
            scroll-step = 5;
            format = "{icon} {volume}%";
            format-muted = " {volume}%";
            format-icons.default = [
              ""
              ""
              ""
              ""
              ""
              ""
            ];
            on-click = "${pamixer} -t && ${volume-update}";
          };

        memory = {
          format = "󰍛 {percentage}%";
          tooltip-format = "{used:0.2f} GiB / {total:0.2f} GiB";
        };

        network = {
          interval = 1;
          format-icons = [
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];
          format-wifi = "{icon} {signalStrength}%";
          format-ethernet = "󰈀 ethernet";
          tooltip-format = "{essid}";
          format-disconnected = "󰤮 Offline";
          on-click = "nm-connection-editor";
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
          format-icons = [
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
            "󰁹"
          ];
        };

        clock = {
          interval = 1;
          format = " {:%I:%M %p}";
          format-alt = " {:%d/%m/%y}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        "custom/notifications" =
          let
            dunstctl = "${config.services.dunst.package}/bin/dunstctl";
            notifications-state = "${customPkgs.waybar-notifications-state}/bin/notifications-state";
            signal = 3; # Workaround since exec-on-event isn't guaranteed
          in
          {
            exec = notifications-state;
            escape = true;
            return-type = "json";
            exec-on-event = false;
            on-click = "${dunstctl} set-paused toggle && pkill -SIGRTMIN+${toString signal} waybar";
            tooltip-format = "Toggle notifications";
            inherit signal;
          };

        "custom/power" =
          let
            rofi-power-menu = "${pkgs.rofi-power-menu}/bin/rofi-power-menu";
          in
          {
            format = "";
            tooltip-format = "Power menu";
            on-click = "rofi -show power-menu -modi power-menu:${rofi-power-menu}";
          };
      };
    };
  };
}
