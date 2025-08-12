{
  config,
  lib,
  pkgs,
  ...
}:
{
  wayland.windowManager.hyprland.settings.exec-once =
    let
      inherit (lib) concatStringsSep;
      uwsmApp = "uwsm app --";

      waybar = "${config.programs.waybar.package}/bin/waybar";
      wbg = "${pkgs.wbg}/bin/wbg";
      polkit-gnome = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      wl-paste = "${pkgs.wl-clipboard}/bin/wl-paste";
      cliphist = "${config.services.cliphist.package}/bin/cliphist";
      eww = "${config.programs.eww.package}/bin/eww";
    in
    [
      "${uwsmApp} ${wbg} ${config.theme.home.wallpaper.source}"
      "${uwsmApp} ${waybar}"
      "${uwsmApp} ${eww} open-many ${concatStringsSep " " config.meta.eww.autostartWidgets}"
      "${uwsmApp} ${polkit-gnome}"
      "${uwsmApp} ${wl-paste} --watch ${cliphist} store"

      "[workspace 7 silent] ${uwsmApp} equibop --start-minimized"
    ];
}
