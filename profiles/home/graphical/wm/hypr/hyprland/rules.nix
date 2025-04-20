{ config, lib, ... }:
{
  wayland.windowManager.hyprland.settings = with config.scheme; {
    windowrule = [ ];

    windowrulev2 =
      let
        dialogTitles = [
          "Open File"
          "Select a File"
          "Choose wallpaper"
          "Open Folder"
          "Save As"
          "Library"
          "File Upload"
        ];

        dialogRules = map (title: [
          "float, title:^(${title})(.*)$"
          "center, title:^(${title})(.*)$"
        ]) dialogTitles;
      in
      [
        # Gives complete control over maximizing
        "suppressevent maximize, class:.*"

        # Don't shadow tiled windows
        "noshadow, floating:0"

        # Border colors for pinned and monocle windows
        "bordercolor rgb(${yellow}), fullscreen:1"

        # Workspace-specific programs
        "workspace 7, class:equibop"
        "workspace 10, class:spotify"

        # Thunar
        "float, class:[Tt]hunar"
        "size 960 540, class:[Tt]hunar"

        # swayimg
        "size 75% 75%, class:swayimg"
        "float, class:swayimg"

        # pavucontrol
        "float, class:org\\.pulseaudio\\.pavucontrol"
        "size 75% 75%, class:org\\.pulseaudio\\.pavucontrol"

        # blueman-manager
        "float, class:\\.blueman-manager-wrapped"
        "center, class:\\.blueman-manager-wrapped"

        # File Roller
        "float, class:org\\.gnome\\.FileRoller"
        "center, class:org\\.gnome\\.FileRoller"

        # nm-connection-editor
        "float, class:nm-connection-editor"
        "center, class:nm-connection-editor"

        # R.nvim help selection popup
        "float, title:^(Choose one)$"
        "center, title:^(Choose one)$"

        # fceux
        "float, class:fceux"
        "size 639 612, class:fceux"
        "center, class:fceux"

        # Steam settings
        "float, title:^(Steam Settings)$"
        "center, title:^(Steam Settings)$"
      ]
      ++ lib.concatLists dialogRules;

    layerrule = [
      # eww widgets
      "noanim, eww-desktop"

      # dunst
      "blur, notifications"
      "ignorezero, notifications"
      "animation slide, notifications"

      # fuzzel
      "blur, launcher"
      "ignorezero, launcher"
      "animation popin 80%, launcher"
      "dimaround, launcher"
    ];
  };
}
