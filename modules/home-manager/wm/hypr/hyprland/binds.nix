{pkgs, ...}: {
  wayland.windowManager.hyprland = {
    settings = {
      "$mainMod" = "SUPER";
      "$moveStep" = 40;
      "$resizeStep" = 20;

      bind = [
        # Hyprland control
        "$mainMod ALT, Q, exit"
        "$mainMod ALT, R, exec, hyprctl reload"

        # Programs
        "$mainMod, Return, exec, $terminal"
        "$mainMod SHIFT, Return, exec, [float; size 50% 50%] $terminal"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, B, exec, $browser"

        # yeah
        "$mainMod CTRL ALT SHIFT, L, exec, $browser \"https://linkedin.com\""

        # Menus
        "$mainMod, Space, exec, pkill rofi || rofi -show drun -show-icons"
        "$mainMod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
        "$mainMod, Period, exec, bemoji -tcn"
        "$mainMod, X, exec, rofi -show menu -modi \"menu:rofi-power-menu\""

        # Screen capture
        ", Print, exec, slurp | grim -g - - | wl-copy"
        "SHIFT, Print, exec, slurp | grim -g - $XDG_SCREENSHOTS_DIR/$(date \"+%Y-%m-%d %H-%S\").png"

        # Window controls
        "$mainMod, Q, killactive"
        "$mainMod, F, fullscreen"
        "$mainMod SHIFT, F, fakefullscreen"
        "$mainMod, M, fullscreen, 1"
        "$mainMod, T, togglefloating"
        "$mainMod, P, pseudo"
        "$mainMod SHIFT, T, togglesplit"

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

        # Preselect
        "$mainMod CTRL, H, layoutmsg, preselect l"
        "$mainMod CTRL, J, layoutmsg, preselect d"
        "$mainMod CTRL, K, layoutmsg, preselect u"
        "$mainMod CTRL, L, layoutmsg, preselect r"

        "$mainMod CTRL, Left, layoutmsg, preselect l"
        "$mainMod CTRL, Down, layoutmsg, preselect d"
        "$mainMod CTRL, Up, layoutmsg, preselect u"
        "$mainMod CTRL, Right, layoutmsg, preselect r"

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
        ", XF86AudioRaiseVolume, exec, pactl -- set-sink-volume @DEFAULT_SINK@ +5%"
        ", XF86AudioLowerVolume, exec, pactl -- set-sink-volume @DEFAULT_SINK@ -5%"
      ];

      bindl = let
        playerctl = "${pkgs.playerctl}/bin/playerctl";
      in [
        ", XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"

        # Player control
        ", XF86AudioPlay, exec, ${playerctl} play-pause"
        ", XF86AudioPrev, exec, ${playerctl} previous"
        ", XF86AudioNext, exec, ${playerctl} next"
      ];

      bindm = [
        # Move and resize windows with mouse
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindn = [
        ", Escape, exec, eww close-all"
      ];

      binds = {
        allow_workspace_cycles = true;
      };
    };

    extraConfig = ''
      # Window move mode
      bind = $mainMod SHIFT, M, submap, Move
      submap = Move

      # Move window focus
      binde = , L, moveactive, $moveStep 0
      binde = , H, moveactive, -$moveStep 0
      binde = , K, moveactive, 0 -$moveStep
      binde = , J, moveactive, 0 $moveStep

      binde = , Left, moveactive, $moveStep 0
      binde = , Down, moveactive, -$moveStep 0
      binde = , Up, moveactive, 0 -$moveStep
      binde = , Right, moveactive, 0 $moveStep

      # Focus last window
      bind = $mainMod, Grave, focuscurrentorlast
      bind = $mainMod, Grave, alterzorder, top

      # Cycle window focus
      bind = $mainMod, C, cyclenext
      bind = $mainMod, C, alterzorder, top
      bind = $mainMod SHIFT, C, cyclenext, prev
      bind = $mainMod SHIFT, C, alterzorder, top

      bind = $mainMod SHIFT, M, submap, reset
      bind = , Q, submap, reset
      bind = , Escape, submap, reset

      bindi = , catchall, exec

      submap = reset
    '';
  };
}
