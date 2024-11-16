{
  config,
  lib,
  ...
}: {
  options = {
    myOwnConfig.hyprland.ewwAutoStart = lib.mkOption {
      description = "eww widgets to autostart with exec-once";
      default = ["desktop-time" "desktop-fortune"];
    };
  };

  config = {
    wayland.windowManager.hyprland.settings.exec-once = [
      "hyprctl setcursor Bibata-Modern-Ice 24"
      "waybar"
      "eww open-many ${lib.strings.concatStringsSep " " config.myOwnConfig.hyprland.ewwAutoStart}"

      "wl-paste --watch cliphist store"

      "dex -a"
      "[workspace 2 silent] $browser"
      "vesktop --start-minimized"
      "[workspace 6 silent] zapzap"

      "foot -a hyprwinwrap-bg -o colors.alpha=0 cava"
    ];
  };
}
