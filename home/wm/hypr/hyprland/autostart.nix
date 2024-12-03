{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    custom.hyprland.ewwAutoStart = lib.mkOption {
      description = "eww widgets to autostart with exec-once";
      default = ["desktop-time" "desktop-fortune"];
    };
  };

  config = {
    wayland.windowManager.hyprland.settings.exec-once = [
      "${pkgs.wbg}/bin/wbg ${config.theme.wallpaper}"
      "hyprctl setcursor Bibata-Modern-Ice 24"
      "waybar"
      "eww open-many ${lib.strings.concatStringsSep " " config.custom.hyprland.ewwAutoStart}"

      "wl-paste --watch cliphist store"

      "${pkgs.dex}/bin/dex -a"
      "[workspace 2 silent] $browser"
      "vesktop --start-minimized"
      "[workspace 6 silent] zapzap"
    ];
  };
}
