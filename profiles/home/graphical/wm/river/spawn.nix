{
  config,
  lib,
  pkgs,
  ...
}: {
  wayland.windowManager.river.settings.spawn = let
    inherit (lib) concatStringsSep escapeShellArg;
    uwsmApp = "uwsm app --";

    wbg = "${pkgs.wbg}/bin/wbg";
    polkit-gnome = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
    wl-paste = "${pkgs.wl-clipboard}/bin/wl-paste";
    cliphist = "${config.services.cliphist.package}/bin/cliphist";
    eww = "${config.programs.eww.package}/bin/eww";

    spawns = [
      "${uwsmApp} ${wbg} ${config.theme.home.wallpaper.source}"
      "${uwsmApp} ${eww} open-many ${concatStringsSep " " config.meta.eww.autostartWidgets}"
      "${uwsmApp} ${polkit-gnome}"
      "${uwsmApp} ${wl-paste} --watch ${cliphist} store"

      "${uwsmApp} equibop --start-minimized"
    ];
  in
    map escapeShellArg spawns;
}
