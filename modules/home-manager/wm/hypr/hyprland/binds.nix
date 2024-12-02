{
  pkgs,
  customPkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    settings = let
      fuzzel = "${pkgs.fuzzel}/bin/fuzzel";
      grim = "${pkgs.grim}/bin/grim";
      slurp = "${pkgs.slurp}/bin/slurp";
      playerctl = "${pkgs.playerctl}/bin/playerctl";
      pamixer = "${pkgs.pamixer}/bin/pamixer";
      volume-update = "${customPkgs.volume-update}/bin/volume-update";
      # TODO: move somewhere else
    in {
      "$mainMod" = "SUPER";
      "$resizeStep" = 20;

      bind = [
        # Hyprland control
        "$mainMod ALT, Q, exit"
        "$mainMod ALT, R, exec, hyprctl reload"

        # Programs
        "$mainMod, Return, exec, $terminal"
        "$mainMod SHIFT, Return, exec, [float; size 50% 50%] $terminal"
        "$mainMod, E, exec, $fileManager"
        "$mainMod SHIFT, E, exec, [float; size 50% 50%] $terminal $fileManagerAlt"
        "$mainMod, B, exec, $browser"
        "$mainMod, O, exec, obsidian"

        # yeah
        ''$mainMod CTRL ALT SHIFT, L, exec, $browser "https://linkedin.com"''

        # Menus
        "$mainMod, Space, exec, ${fuzzel}"
        "$mainMod, V, exec, cliphist list | ${fuzzel} -d | cliphist decode | wl-copy"
        "$mainMod, Period, exec, BEMOJI_PICKER_CMD='${fuzzel} -d' ${pkgs.bemoji}/bin/bemoji -n -t"
        "$mainMod SHIFT, X, exec, ${customPkgs.fuzzel-power-menu}/bin/fuzzel-power-menu"
        "$mainMod, Slash, exec, ${customPkgs.menu-qalc}/bin/="

        # Screen capture
        ", Print, exec, pidof -q slurp || ${slurp} -w 0 -b 00000088 | ${grim} -g - - | wl-copy"
        "SHIFT, Print, exec, pidof -q slurp || ${slurp} -ro -w 0 -b 00000088 -B 00000088 | ${grim} -g - - | wl-copy"

        # Window controls
        "$mainMod, Q, exec, ${customPkgs.close-window}/bin/close-window"
        "$mainMod, F, fullscreen"
        "$mainMod, M, fullscreen, 1"
        "$mainMod, T, togglefloating"

        # Move window focus
        "$mainMod, H, movefocus, l"
        "$mainMod, H, alterzorder, top"
        "$mainMod, J, movefocus, d"
        "$mainMod, J, alterzorder, top"
        "$mainMod, K, movefocus, u"
        "$mainMod, K, alterzorder, top"
        "$mainMod, L, movefocus, r"
        "$mainMod, L, alterzorder, top"

        "$mainMod, Left, movefocus, l"
        "$mainMod, Left, alterzorder, top"
        "$mainMod, Down, movefocus, d"
        "$mainMod, Down, alterzorder, top"
        "$mainMod, Up, movefocus, u"
        "$mainMod, Up, alterzorder, top"
        "$mainMod, Right, movefocus, r"
        "$mainMod, Right, alterzorder, top"

        # Focus last window
        "$mainMod, Grave, focuscurrentorlast"
        "$mainMod, Grave, alterzorder, top"

        # Cycle window focus
        "$mainMod, C, cyclenext"
        "$mainMod, C, alterzorder, top"
        "$mainMod SHIFT, C, cyclenext, prev"
        "$mainMod SHIFT, C, alterzorder, top"

        # Swap windows
        "$mainMod SHIFT, H, swapwindow, l"
        "$mainMod SHIFT, J, swapwindow, d"
        "$mainMod SHIFT, K, swapwindow, u"
        "$mainMod SHIFT, L, swapwindow, r"

        "$mainMod SHIFT, Left, swapwindow, l"
        "$mainMod SHIFT, Down, swapwindow, d"
        "$mainMod SHIFT, Up, swapwindow, u"
        "$mainMod SHIFT, Right, swapwindow, r"

        # Switch workspaces
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Travel workspaces
        "$mainMod, A, workspace, r-1"
        "$mainMod, S, workspace, r+1"
        "$mainMod CTRL, A, focusmonitor, l"
        "$mainMod CTRL, S, focusmonitor, r"

        # Switch to previous workspace
        "$mainMod, Tab, workspace, previous"

        # Move window to workspace
        "$mainMod SHIFT, 1, movetoworkspacesilent, 1"
        "$mainMod SHIFT, 2, movetoworkspacesilent, 2"
        "$mainMod SHIFT, 3, movetoworkspacesilent, 3"
        "$mainMod SHIFT, 4, movetoworkspacesilent, 4"
        "$mainMod SHIFT, 5, movetoworkspacesilent, 5"
        "$mainMod SHIFT, 6, movetoworkspacesilent, 6"
        "$mainMod SHIFT, 7, movetoworkspacesilent, 7"
        "$mainMod SHIFT, 8, movetoworkspacesilent, 8"
        "$mainMod SHIFT, 9, movetoworkspacesilent, 9"
        "$mainMod SHIFT, 0, movetoworkspacesilent, 10"
        "$mainMod SHIFT, A, movetoworkspacesilent, r-1"
        "$mainMod SHIFT, S, movetoworkspacesilent, r+1"

        # Special workspace (scratchpad)
        "$mainMod, W, togglespecialworkspace"
        "$mainMod SHIFT, W, movetoworkspacesilent, special"

        # Travel workspaces with mouse
        "$mainMod, mouse_up, workspace, r+1"
        "$mainMod, mouse_down, workspace, r-1"

        # Brightness control
        ", XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl set 5%+"
        ", XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl set 5%-"
      ];

      binde = [
        # Resize window
        "$mainMod ALT, H, resizeactive, -$resizeStep 0"
        "$mainMod ALT, J, resizeactive, 0 $resizeStep"
        "$mainMod ALT, K, resizeactive, 0 -$resizeStep"
        "$mainMod ALT, L, resizeactive, $resizeStep 0"

        "$mainMod ALT, Left, resizeactive, -$resizeStep 0"
        "$mainMod ALT, Down, resizeactive, 0 $resizeStep"
        "$mainMod ALT, Up, resizeactive, 0 -$resizeStep"
        "$mainMod ALT, Right, resizeactive, $resizeStep 0"
      ];

      bindel = [
        # Audio control
        ", XF86AudioRaiseVolume, exec, ${pamixer} -i 5 && ${volume-update}"
        ", XF86AudioLowerVolume, exec, ${pamixer} -d 5 && ${volume-update}"
      ];

      bindl = [
        ", XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle && ${volume-update}"

        # Player control
        ", XF86AudioPlay, exec, ${playerctl} -p spotify play-pause"
        ", XF86AudioPrev, exec, ${playerctl} -p spotify previous"
        ", XF86AudioNext, exec, ${playerctl} -p spotify next"
      ];

      bindm = [
        # Move and resize windows with mouse
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      binds = {
        allow_workspace_cycles = true;
      };
    };
  };
}
