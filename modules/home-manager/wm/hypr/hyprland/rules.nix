{theme, ...}: {
  wayland.windowManager.hyprland.settings = let
    colors = theme.colors.hexNh;
  in {
    windowrule = [
      "float, ^([Tt]hunar)$"
      "float, ^(org.pulseaudio.pavucontrol)$"
      "float, blueman-manager"
      "float, ^(org.gnome.FileRoller)$"
      "float, ^(nm-connection-editor)$"
      "float, ^(steam)$"

      "size 960 540, ^([Tt]hunar)$" # Thunar is too small by default

      # Workspace-specific programs
      "workspace 3, ^(obsidian)$"
      "workspace 6, ^(.*)(\.zapzap)$"
      "workspace 7, ^(vesktop)$"
      "workspace 10, title:(Spotify)"
    ];

    windowrulev2 = [
      "bordercolor rgb(${colors.brightYellow}), pinned:1"
      "bordercolor rgb(${colors.white}), fullscreen:1"

      "suppressevent maximize, class:.*"
    ];

    layerrule = [
      "noanim, eww-desktop"

      "blur, notifications"
      "ignorezero, notifications"
      "animation slide, notifications"

      "blur, launcher"
      "ignorezero, launcher"
      "animation popin 80%, launcher"
      "dimaround, launcher"
    ];
  };
}
