{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "float, ^([Tt]hunar)$"
      "float, ^(org.pulseaudio.pavucontrol)$"
      "float, blueman-manager"
      "float, ^(org.kde.ark)$"
      "float, ^(nm-connection-editor)$"
      "float, ^(steam)$"

      "float, title:^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$"
      "center, title:^(Open File)(.*)$"
      "center, title:^(Select a File)(.*)$"
      "center, title:^(Choose wallpaper)(.*)$"
      "center, title:^(Open Folder)(.*)$"
      "center, title:^(Save As)(.*)$"
      "center, title:^(Library)(.*)$"
      "center, title:^(File Upload)(.*)$"

      # Dialogs
      "float, title:^(Open File)(.*)$"
      "float, title:^(Select a File)(.*)$"
      "float, title:^(Choose wallpaper)(.*)$"
      "float, title:^(Open Folder)(.*)$"
      "float, title:^(Save As)(.*)$"
      "float, title:^(Library)(.*)$"
      "float, title:^(File Upload)(.*)$"

      "size 960 540, ^([Tt]hunar)$" # Thunar is too small by default

      # Workspace-specific programs
      "workspace 3, ^(obsidian)$"
      "workspace 6, ^(.*)(\.zapzap)$"
      "workspace 7, ^(vesktop)$"
      "workspace 10, title:(Spotify)"
    ];

    windowrulev2 = [
      "tile, initialTitle:^(MATLAB), class:^(MATLAB)"

      "bordercolor rgb(e6c384), pinned:1"
      "bordercolor rgb(c8c093), fullscreen:1"

      "suppressevent maximize, class:.*"
    ];

    layerrule = [
      "noanim, eww-bg"
    ];
  };
}
