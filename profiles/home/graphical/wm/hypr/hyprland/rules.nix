{ config, lib, ... }:
{
  wayland.windowManager.hyprland.settings = with config.scheme; {
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
        ]) dialogTitles;
      in
      [
        # Gives complete control over maximizing
        "suppressevent maximize, class:.*"

        # Border colors for pinned and monocle windows
        "bordercolor rgb(${yellow}), fullscreen:1"

        # Workspace-specific programs
        "workspace 7, class:equibop"
        "workspace 10, class:spotify"

        "float, class:[Tt]hunar"
        # "size 960 540, class:[Tt]hunar"

        # swayimg
        "size 90% 90%, class:swayimg_(.*)"
        "float, class:swayimg_(.*)"
        "center, class:swayimg_(.*)"

        # pavucontrol
        "float, class:org\\.pulseaudio\\.pavucontrol"
        "size 75% 75%, class:org\\.pulseaudio\\.pavucontrol"

        "float, class:\\.blueman-manager-wrapped"
        "float, class:org\\.gnome\\.FileRoller"
        "float, class:nm-connection-editor"
        "float, class:nvidia-settings"
        "float, title:^(Choose one)$"
        "float, title:^(Steam Settings)$"
        "float, class:fceux"
        "size 639 612, class:fceux"
      ]
      ++ lib.concatLists dialogRules;

    layerrule = [
      # fuzzel
      "dimaround, launcher"
    ];
  };
}
