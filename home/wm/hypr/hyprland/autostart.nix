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
      "${pkgs.wbg}/bin/wbg ${config.theme.home.wallpaper.source}"
      "${config.programs.waybar.package}/bin/waybar"
      "${config.programs.eww.package}/bin/eww open-many ${lib.strings.concatStringsSep " " config.custom.hyprland.ewwAutoStart}"
      "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"

      "${pkgs.wl-clipboard}/bin/wl-paste --watch ${pkgs.cliphist}/bin/cliphist store"

      "[workspace 2 silent] $browser"
      "[workspace 7 silent] ${pkgs.equibop}/bin/equibop --start-minimized"
    ];
  };
}
