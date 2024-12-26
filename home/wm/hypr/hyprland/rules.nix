{config, ...}: {
  wayland.windowManager.hyprland.settings = let
    colors = config.theme.colors.hex;
  in {
    windowrule = [
      # Floating apps
      "float, ^([Tt]hunar)$"
      "float, ^(org.pulseaudio.pavucontrol)$"
      "float, ^(.blueman-manager-wrapped)$"
      "float, ^(org.gnome.FileRoller)$"
      "float, ^(nm-connection-editor)$"
      "float, title:^(Steam Settings)$"
      "float, ^(swayimg)$"
      "float, ^(fceux)$"

      # Dialogs
      "center, title:^(Open File)(.*)$"
      "center, title:^(Select a File)(.*)$"
      "center, title:^(Choose wallpaper)(.*)$"
      "center, title:^(Open Folder)(.*)$"
      "center, title:^(Save As)(.*)$"
      "center, title:^(Library)(.*)$"
      "center, title:^(File Upload)(.*)$"
      "float, title:^(Open File)(.*)$"
      "float, title:^(Select a File)(.*)$"
      "float, title:^(Choose wallpaper)(.*)$"
      "float, title:^(Open Folder)(.*)$"
      "float, title:^(Save As)(.*)$"
      "float, title:^(Library)(.*)$"
      "float, title:^(File Upload)(.*)$"

      # Sizing
      "size 960 540, ^([Tt]hunar)$"
      "size 75% 75%, ^(swayimg)$"
      "size 75% 75%, ^(org.pulseaudio.pavucontrol)$"
      "size 639 612, ^(fceux)$"

      # Workspace-specific programs
      "workspace 3, ^(obsidian)$"
      "workspace 6, ^(.*)(\.zapzap)$"
      "workspace 7, ^(vesktop)$"
      "workspace 10, title:(Spotify)"
    ];

    windowrulev2 = [
      # Don't shadow tiled windows
      "noshadow, floating:0"

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
