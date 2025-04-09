{
  config,
  pkgs,
  customPkgs,
  ...
} @ moduleArgs: {
  programs.waybar = {
    enable = true;

    style = (import ./style.nix) moduleArgs;

    settings = {
      mainBar = {
        reload_style_on_change = true;

        layer = "bottom";
        position = "top";
        height = 24;
        spacing = 0; # I prefer to use CSS margin

        modules-left = [
          "custom/sysmenu"
          "tray"
          "custom/media"
        ];

        modules-center = ["river/tags"];

        modules-right = [
          "pulseaudio"
          "network"
          "battery"
          "clock"
          "custom/notifications"
          "custom/power"
        ];

        "custom/sysmenu" = {
          format = "";
          tooltip-format = "App launcher";
          on-click = config.meta.mainPrograms.appLauncher;
        };

        tray = {
          spacing = 10;
        };

        "custom/media" = let
          playerctl = "${pkgs.playerctl}/bin/playerctl -p mopidy";
          media-query = "${customPkgs.waybar-media-query}/bin/media-query";
        in {
          interval = 1;
          format = "{}";
          escape = true;
          return-type = "json";
          max-length = 35;
          on-click = "${playerctl} play-pause";
          exec = media-query;
        };

        "river/tags" = {
          num-tags = 10;
          tag-labels =
            (builtins.genList (n: toString (n + 1)) 9)
            ++ ["S"];
        };

        pulseaudio = let
          pamixer = "${pkgs.pamixer}/bin/pamixer";
          volume-update = "${customPkgs.volume-update}/bin/volume-update";
        in {
          scroll-step = 5;
          format = "{icon} {volume}%";
          format-muted = " {volume}%";
          format-icons.default = ["" ""];
          on-click = "${pamixer} -t && ${volume-update}";
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
          notifications-state = "${customPkgs.waybar-notifications-state}/bin/notifications-state";
          signal = 3; # Workaround since exec-on-event isn't guaranteed
        in {
          exec = notifications-state;
          escape = true;
          return-type = "json";
          exec-on-event = false;
          on-click = "${dunstctl} set-paused toggle && pkill -SIGRTMIN+${toString signal} waybar";
          tooltip-format = "Toggle notifications";
          inherit signal;
        };

        "custom/power" = let
          fuzzel-power-menu = "${customPkgs.fuzzel-power-menu}/bin/fuzzel-power-menu";
        in {
          format = "";
          tooltip-format = "Power menu";
          on-click = fuzzel-power-menu;
        };
      };
    };
  };
}
