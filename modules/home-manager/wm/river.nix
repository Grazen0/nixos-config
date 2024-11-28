{
  config,
  lib,
  pkgs,
  theme,
  ...
}: {
  wayland.windowManager.river = {
    enable = true;

    settings = let
      colors = theme.colors.hexNum;
    in {
      background-color = colors.background;

      border-width = 3;
      border-color-focused = colors.blue;
      border-color-unfocused = colors.brightBlack;
      border-color-urgent = colors.magenta;

      spawn = let
        wlr-randr = "${pkgs.wlr-randr}/bin/wlr-randr";
      in
        map (cmd: "'${cmd}'") [
          "${pkgs.wbg}/bin/wbg ${../../../files/wallpaper.png}"
          "waybar"
          "eww open-many ${lib.strings.concatStringsSep " " config.custom.hyprland.ewwAutoStart}"

          "${wlr-randr} --output eDP-1 --adaptive-sync enabled"
          "${wlr-randr} --output HDMI-A-1 --adaptive-sync enabled"
          "${wlr-randr} --output eDP-1 --scale 1.2 --pos 0,0"
          "${wlr-randr} --output HDMI-A-1 --pos -1366,312 --scale 1"

          "wl-paste --watch cliphist store"

          "${pkgs.dex}/bin/dex -a"
          "zen"
          "zapzap"
        ];

      keyboard-layout = "-options 'grp:alt_shift_toggle,caps:swapescape' us,latam";

      map = let
        terminal = "foot";
        browser = "zen";
        fileManager = "thunar";
        fileManagerAlt = "${terminal} yazi";
        grim = "${pkgs.grim}/bin/grim";
        slurp = "${pkgs.slurp}/bin/slurp";
        playerctl = "${pkgs.playerctl}/bin/playerctl";
        pamixer = "${pkgs.pamixer}/bin/pamixer";
        brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
        volume-update = "${pkgs.customScripts.volume-update}/bin/volume-update";
      in {
        normal = {
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
          "Super+Shift Return" = "spawn '${terminal}'";
          "Super B" = "spawn '${browser}'";
          "Super E" = "spawn '${fileManager}'";
          "Super+Shift E" = "spawn '${fileManagerAlt}'";

          "None Print" = "spawn 'pidof -q slurp || ${slurp} -w 0 -b 00000088 | ${grim} -g - - | wl-copy'";
          "Shift Print" = "spawn 'pidof -q slurp || ${slurp} -ro -w 0 -b 00000088 -B 00000088 | ${grim} -g - - | wl-copy'";

          "Super T" = "toggle-float";
          "Super F" = "toggle-fullscreen";

          "None XF86AudioMute" = "spawn '${pamixer} -t && ${volume-update}'";

          "None XF86AudioPlay" = "spawn '${playerctl} -p spotify play-pause'";
          "None XF86AudioPrev" = "spawn '${playerctl} -p spotify previous'";
          "None XF86AudioNext" = "spawn '${playerctl} -p spotify next'";
        };

        "-repeat".normal = {
          "None XF86MonBrightnessUp" = "spawn '${brightnessctl} set 5%+'";
          "None XF86MonBrightnessDown" = "spawn '${brightnessctl} set 5%-'";

          "None XF86AudioRaiseVolume" = "spawn '${pamixer} -i 5 && ${volume-update}'";
          "None XF86AudioLowerVolume" = "spawn '${pamixer} -d 5 && ${volume-update}'";
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
      rivertile -view-padding 4 -outer-padding 0 &
    '';
  };
}
