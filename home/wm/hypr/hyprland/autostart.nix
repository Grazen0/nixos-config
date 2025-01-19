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
    wayland.windowManager.hyprland.settings.exec-once = let
      uwsmApp = "uwsm app --";
    in [
      "${uwsmApp} ${pkgs.wbg}/bin/wbg ${config.theme.home.wallpaper.source}"
      "${uwsmApp} ${config.programs.waybar.package}/bin/waybar"
      "${uwsmApp} ${config.programs.eww.package}/bin/eww open-many ${lib.strings.concatStringsSep " " config.custom.hyprland.ewwAutoStart}"
      "${uwsmApp} ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"

      "${uwsmApp} ${pkgs.wl-clipboard}/bin/wl-paste --watch ${pkgs.cliphist}/bin/cliphist store"

      "[workspace 2 silent] ${uwsmApp} $browser"
      "[workspace 7 silent] ${uwsmApp} ${pkgs.equibop}/bin/equibop --start-minimized"
    ];
  };
}
