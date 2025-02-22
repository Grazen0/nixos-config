{
  config,
  lib,
  pkgs,
  ...
}: {
  wayland.windowManager.river.settings.spawn = let
    uwsmApp = "uwsm app --";
    wbg = "${pkgs.wbg}/bin/wbg";
    waybar = "${config.programs.waybar.package}/bin/waybar";
    polkit-gnome = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
    wl-paste = "${pkgs.wl-clipboard}/bin/wl-paste";
    cliphist = "${config.services.cliphist.package}/bin/cliphist";
    equibop = "${pkgs.equibop}/bin/equibop";

    spawns = [
      "${uwsmApp} ${wbg} ${config.theme.home.wallpaper.source}"
      "${uwsmApp} ${waybar}"
      "${uwsmApp} ${polkit-gnome}"
      "${uwsmApp} ${wl-paste} --watch ${cliphist} store"

      "${uwsmApp} ${equibop} --start-minimized"

      # TODO: browser autostart
    ];
  in
    map lib.escapeShellArg spawns;
}
