{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "float, thunar"
      "float, ^(org.pulseaudio.pavucontrol)$"
      "float, blueman-manager"
      "float, ^(nm-connection-editor)$"

      "workspace 3, ^(obsidian)$"
      "workspace 6, ^(vesktop)$"
      "workspace 10, title:Spotify"
    ];

    windowrulev2 = [
      "bordercolor rgb(e6c384), pinned:1"
      "noborder, fullscreen:1"
      "opacity 0.8, floating:1, focus:0"

      "suppressevent maximize, class:.*"
    ];
  };
}
