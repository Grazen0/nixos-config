{
  config,
  lib,
  ...
}: {
  wayland.windowManager.hyprland.settings = let
    colors = config.theme.colors.hex;
  in {
    windowrule = [
    ];

    windowrulev2 = let
      dialogTitles = [
        "Open File"
        "Select a File"
        "Choose wallpaper"
        "Open Folder"
        "Save As"
        "Library"
        "File Upload"
      ];

      dialogRules =
        map (title: [
          "float, title:^(${title})(.*)$"
          "center, title:^(${title})(.*)$"
        ])
        dialogTitles;
    in
      [
        # Gives complete control over fullscreen
        "suppressevent maximize, class:.*"
        "suppressevent fullscreen, class:.*"

        # Don't shadow tiled windows
        "noshadow, floating:0"

        # Border colors for pinned and monocle windows
        "bordercolor rgb(${colors.brightYellow}), pinned:1"
        "bordercolor rgb(${colors.white}), fullscreen:1"

        # Thunar
        "float, class:[Tt]hunar"
        "size 960 540, class:[Tt]hunar"

        # swayimg
        "size 75% 75%, class:swayimg"
        "float, class:swayimg"

        # pavucontrol
        "size 75% 75%, class:pavucontrol"
        "float, class:pavucontrol"

        # fceux
        "float, class:fceux"
        "size 639 612, class:fceux"
        "center, class:fceux"

        # Workspace-specific programs
        "workspace 7, class:equibop"
        "workspace 10, class:spotify"

        # Other misc apps
        "float, class:blueman-manager"
        "float, class:FileRoller"
        "float, class:nm-connection-editor"
        "float, title:^(Steam Settings)$"
      ]
      ++ lib.concatLists dialogRules;

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
