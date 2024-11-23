{
  config,
  lib,
  pkgs,
  ...
}: {
  wayland.windowManager.river = {
    enable = true;

    settings = let
      colors = config.theme.colors.hexNum;
    in {
      background-color = colors.background;

      border-width = 3;
      border-color-focused = colors.blue;
      border-color-unfocused = colors.brightBlack;
      border-color-urgent = colors.magenta;

      spawn = [
        "waybar"
        "eww open-many ${lib.strings.concatStringsSep " " config.myOwnConfig.hyprland.ewwAutoStart}"

        "wl-paste --watch cliphist store"

        "dex -a"
        "zen"
        "zapzap"
      ];

      map = {
        normal = let
          terminal = "foot";
          browser = "zen";
          fileManager = "thunar";
          grim = "${pkgs.grim}/bin/grim";
          slurp = "${pkgs.slurp}/bin/slurp";
          playerctl = "${pkgs.playerctl}/bin/playerctl";
        in {
          "Super+Alt Q" = "exit";

          # TODO: refactor close-window script to use River
          "Super Q" = "close";

          "Super H" = "focus-view left";
          "Super J" = "focus-view down";
          "Super K" = "focus-view up";
          "Super L" = "focus-view right";

          "Super C" = "focus-view next";
          "Super Shift C" = "focus-view previous";

          # Window sending
          "Super+Shift H" = "swap left";
          "Super+Shift J" = "swap down";
          "Super+Shift K" = "swap up";
          "Super+Shift L" = "swap right";

          "Super A" = "focus-output previous";
          "Super S" = "focus-output next";

          "Super+Shift A" = "send-to-output previous";
          "Super+Shift S" = "send-to-output next";

          # Rofis
          "Super Space" = "spawn 'pkill rofi || rofi -show drun -show-icons'";
          "Super V" = "spawn 'cliphist list | rofi -dmenu | cliphist decode | wl-copy'";
          "Super Period" = "spawn 'rofi -modi emoji -show emoji'";
          "Super+Shift X" = "spawn 'rofi -show menu -modi \"menu:rofi-power-menu\"'";
          "Super Slash" = "spawn 'rofi -show calc -modi calc -no-show-match -no-sort -terse -hint-result \"\" -calc-command \"echo -n '{result}' | wl-copy\"'";

          "Super Return" = "spawn '${terminal}'";
          "Super B" = "spawn '${browser}'";
          "Super E" = "spawn '${fileManager}'";

          "None Print" = "spawn 'pidof -q slurp || ${slurp} -w 0 -b 00000088 | ${grim} -g - - | wl-copy'";
          "Shift Print" = "spawn 'pidof -q slurp || ${slurp} -ro -w 0 -b 00000088 -B 00000088 | ${grim} -g - - | wl-copy'";

          "Super T" = "toggle-float";
          "Super F" = "toggle-fullscreen";

          "None XF86MonBrightnessUp" = "spawn '${pkgs.brightnessctl}/bin/brightnessctl set 5%+'";
          "None XF86MonBrightnessDown" = "spawn '${pkgs.brightnessctl}/bin/brightnessctl set 5%-'";
          "None XF86AudioRaiseVolume" = "spawn 'pactl -- set-sink-volume @DEFAULT_SINK@ +5%'";
          "None XF86AudioLowerVolume" = "spawn 'pactl -- set-sink-volume @DEFAULT_SINK@ -5%'";
          "None XF86AudioMute" = "spawn 'pactl set-sink-mute @DEFAULT_SINK@ toggle'";

          "None XF86AudioPlay" = "spawn '${playerctl} -p spotify play-pause'";
          "None XF86AudioPrev" = "spawn '${playerctl} -p spotify previous'";
          "None XF86AudioNext" = "spawn '${playerctl} -p spotify next'";
        };
      };

      set-repeat = "50 300";
      hide-cursor = 10000;

      map-pointer.normal = {
        "Super BTN_LEFT" = "move-view";
        "Super BTN_RIGHT" = "resize-view";
        "Super BTN_MIDDLE" = "toggle-float";
      };

      xcursor-theme = "Bibata-Modern-Ice 24";

      default-layout = "rivertile";
    };

    extraConfig = ''
      rivertile -view-padding 6 -outer-padding 6 &
    '';

    extraSessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };
}
