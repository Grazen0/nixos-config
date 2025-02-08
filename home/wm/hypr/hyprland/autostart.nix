{
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland.settings.exec-once = let
    inherit (config.meta.mainPrograms) browser;
    uwsmApp = "uwsm app --";
  in [
    "${uwsmApp} ${pkgs.wbg}/bin/wbg ${config.theme.home.wallpaper.source}"
    "${uwsmApp} ${config.programs.waybar.package}/bin/waybar"
    "${uwsmApp} ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"

    "${uwsmApp} ${pkgs.wl-clipboard}/bin/wl-paste --watch ${pkgs.cliphist}/bin/cliphist store"

    "[workspace 2 silent] ${uwsmApp} ${browser}"
    "[workspace 7 silent] ${uwsmApp} ${pkgs.equibop}/bin/equibop --start-minimized"
  ];
}
