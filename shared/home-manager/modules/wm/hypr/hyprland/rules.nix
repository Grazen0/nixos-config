{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "float, Thunar"
      "float, thunar"
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

      "workspace 3, ^(obsidian)$"
      "workspace 6, ^(com.rtosta.zapzap)$"
      "workspace 7, ^(vesktop)$"
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
