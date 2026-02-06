{ config, lib, ... }:
{
  wayland.windowManager.hyprland.settings = with config.scheme; {
    windowrule =
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

        dialogRules = map (title: [ "match:title ^(${title})(.*)$, float on" ]) dialogTitles;
      in
      [
        # Gives complete control over maximizing
        "match:class .*, suppress_event maximize"

        # Border colors for pinned and monocle windows
        "match:fullscreen 1, border_color rgb(${yellow})"

        # Workspace-specific programs
        "match:class equibop, workspace 7"
        "match:class spotify, workspace 10"

        "match:class [Tt]hunar, float on"
        "match:class [Tt]hunar, size 960 540"

        # swayimg
        "match:class swayimg_(.*), size 90% 90%"
        "match:class swayimg_(.*), float on"
        "match:class swayimg_(.*), center on"

        # pavucontrol
        "match:class org\\.pulseaudio\\.pavucontrol, float on"
        "match:class org\\.pulseaudio\\.pavucontrol, size 75% 75%"

        "match:class \\.blueman-manager-wrapped, float on"
        "match:class org\\.gnome\\.FileRoller, float on"
        "match:class nm-connection-editor, float on"
        "match:class nvidia-settings, float on"
        "match:title ^(Choose one)$, float on"
        "match:title ^(Steam Settings)$, float on"
        "match:class fceux, float on"
        "match:class fceux, size 639 612"
        "match:class gemu, float on"
        "match:class gtkwave, float on"
        "match:title Logic Simulator, float on"
      ]
      ++ lib.concatLists dialogRules;
  };
}
