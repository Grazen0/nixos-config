{
  config,
  lib,
  pkgs,
  stablePkgs, # TODO: update when wbg compiles in unstable
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
      "${stablePkgs.wbg}/bin/wbg ${config.theme.home.wallpaper.source}"
      "waybar"
      "eww open-many ${lib.strings.concatStringsSep " " config.custom.hyprland.ewwAutoStart}"

      "${pkgs.wl-clipboard}/bin/wl-paste --watch ${pkgs.cliphist}/bin/cliphist store"

      "${pkgs.dex}/bin/dex -a"
      "[workspace 2 silent] $browser"
      "[workspace 7 silent] equibop --start-minimized"
      "[workspace 6 silent] zapzap"
    ];
  };
}
