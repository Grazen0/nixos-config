{
  config,
  lib,
  pkgs,
  ...
}:
{
  wayland.windowManager.river.settings.spawn =
    let
      inherit (lib) concatStringsSep escapeShellArg;

      wbg = "${pkgs.wbg}/bin/wbg";
      polkit-gnome = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      wl-paste = "${pkgs.wl-clipboard}/bin/wl-paste";
      cliphist = "${config.services.cliphist.package}/bin/cliphist";
      eww = "${config.programs.eww.package}/bin/eww";

      spawns = [
        "${wbg} ${config.theme.home.wallpaper.source}"
        "${eww} open-many ${concatStringsSep " " config.meta.eww.autostartWidgets}"
        "${polkit-gnome}"
        "${wl-paste} --watch ${cliphist} store"

        "vesktop --start-minimized"
      ];
    in
    map escapeShellArg spawns;
}
