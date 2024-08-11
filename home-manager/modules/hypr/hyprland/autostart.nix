{pkgs, ...}: {
  wayland.windowManager.hyprland.settings.exec-once = [
    "hyprctl setcursor Bibata-Modern-Ice 24"
    "waybar"

    "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
    # "dunst"
    "wl-paste --watch cliphist store"

    "dex -a"
    "[workspace 2 silent] $browser"
    "discord --start-minimized"
  ];
}
