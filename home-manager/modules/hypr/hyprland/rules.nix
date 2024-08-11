{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "float, thunar"
      "float, ^(org.pulseaudio.pavucontrol)$"
      "float, blueman-manager"
      "float, ^(nm-connection-editor)$"
      "float, ^(nvidia-settings)$"

      "workspace 3, ^(obsidian)$"
      "workspace 6, ^(discord)$"
      "workspace 10, Spotify"
    ];

    windowrulev2 = [
      "bordercolor rgb(e6c384), pinned:1"
      "noborder, fullscreen:1"
      "suppressevent maximize, class:.*"
      "opacity 0.85, floating:1, focus:0"
    ];
  };
}
