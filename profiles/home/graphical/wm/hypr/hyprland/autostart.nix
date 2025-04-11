{
  config,
  lib,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland.settings.exec-once = let
    inherit (lib) concatStringsSep;
    inherit (config.meta.mainPrograms) browser;
    uwsmApp = "uwsm app --";

    wbg = "${pkgs.wbg}/bin/wbg";
    polkit-gnome = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
    wl-paste = "${pkgs.wl-clipboard}/bin/wl-paste";

    eww = "${config.programs.eww.package}/bin/eww";
  in [
    "${uwsmApp} ${wbg} ${config.theme.home.wallpaper.source}"
    "${uwsmApp} ${eww} open-many ${concatStringsSep " " config.meta.eww.autostartWidgets}"
    "${uwsmApp} ${polkit-gnome}"
    "${uwsmApp} ${wl-paste} --watch ${pkgs.cliphist}/bin/cliphist store"

    "[workspace 2 silent] ${uwsmApp} ${browser}"
    "[workspace 7 silent] ${uwsmApp} equibop --start-minimized"
  ];
}
