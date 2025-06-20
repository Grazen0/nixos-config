{
  config,
  pkgs,
  customPkgs,
  ...
}:
{
  home.packages = with pkgs; [
    wtype # Required for bemoji
  ];

  wayland.windowManager.hyprland = {
    settings =
      let
        inherit (config.meta.mainPrograms)
          terminal
          browser
          fileManager
          fileManagerCli
          appLauncher
          dmenu
          ;
        grim = "${pkgs.grim}/bin/grim";
        slurp = "${pkgs.slurp}/bin/slurp";
        playerctl = "${pkgs.playerctl}/bin/playerctl -p mopidy";
        pamixer = "${pkgs.pamixer}/bin/pamixer";
        wl-copy = "${pkgs.wl-clipboard}/bin/wl-copy";
        cliphist = "${config.services.cliphist.package}/bin/cliphist";
        brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
        volume-update = "${customPkgs.volume-update}/bin/volume-update";
        fuzzel-power-menu = "${customPkgs.fuzzel-power-menu}/bin/fuzzel-power-menu";
        menu-qalc = "${customPkgs.menu-qalc}/bin/=";

        volumeStep = "5";
        resizeStep = "20";
        uwsmApp = "uwsm app --";
      in
      {
        bind = [
          # Hyprland control
          "SUPER ALT, Q, exec, uwsm stop"
          "SUPER ALT, R, exec, hyprctl reload"

          # Programs
          "SUPER, Return, exec, ${uwsmApp} ${terminal}"
          "SUPER SHIFT, Return, exec, [float; size 960 540] ${uwsmApp} ${terminal}"
          "SUPER, E, exec, ${uwsmApp} ${fileManager}"
          "SUPER SHIFT, E, exec, [float; size 960 540] ${uwsmApp} ${terminal} ${fileManagerCli}"
          "SUPER, B, exec, ${uwsmApp} ${browser}"
          "SUPER, O, exec, ${uwsmApp} obsidian"

          # Menus
          "SUPER, Space, exec, ${appLauncher}"
          "SUPER, V, exec, ${cliphist} list | ${dmenu} | ${cliphist} decode | ${wl-copy}"
          "SUPER, Period, exec, BEMOJI_PICKER_CMD='${dmenu} -d' ${pkgs.bemoji}/bin/bemoji -n -t"
          "SUPER, Comma, exec, ${uwsmApp} ${menu-qalc} --dmenu=fuzzel"
          "SUPER SHIFT, X, exec, ${uwsmApp} ${fuzzel-power-menu}"

          # Screen capture
          ", Print, exec, pidof -q slurp || ${slurp} -w 0 -b 00000088 | ${grim} -g - - | ${wl-copy}"
          "SHIFT, Print, exec, pidof -q slurp || ${slurp} -ro -w 0 -b 00000088 -B 00000088 | ${grim} -g - - | ${wl-copy}"

          # Window controls
          "SUPER, Q, killactive"
          "SUPER, F, fullscreen"
          "SUPER, M, fullscreen, 1"
          "SUPER, T, togglefloating"
          "SUPER SHIFT, T, togglesplit"

          # Move window focus
          "SUPER, H, movefocus, l"
          "SUPER, H, alterzorder, top"
          "SUPER, J, movefocus, d"
          "SUPER, J, alterzorder, top"
          "SUPER, K, movefocus, u"
          "SUPER, K, alterzorder, top"
          "SUPER, L, movefocus, r"
          "SUPER, L, alterzorder, top"

          # Focus last window
          "SUPER, Grave, focuscurrentorlast"
          "SUPER, Grave, alterzorder, top"

          # Cycle window focus
          "SUPER, C, cyclenext"
          "SUPER, C, alterzorder, top"
          "SUPER SHIFT, C, cyclenext, prev"
          "SUPER SHIFT, C, alterzorder, top"

          # Swap windows
          "SUPER SHIFT, H, swapwindow, l"
          "SUPER SHIFT, J, swapwindow, d"
          "SUPER SHIFT, K, swapwindow, u"
          "SUPER SHIFT, L, swapwindow, r"

          # Switch workspaces
          "SUPER, 1, workspace, 1"
          "SUPER, 2, workspace, 2"
          "SUPER, 3, workspace, 3"
          "SUPER, 4, workspace, 4"
          "SUPER, 5, workspace, 5"
          "SUPER, 6, workspace, 6"
          "SUPER, 7, workspace, 7"
          "SUPER, 8, workspace, 8"
          "SUPER, 9, workspace, 9"
          "SUPER, 0, workspace, 10"

          # Travel workspaces
          "SUPER, A, workspace, r-1"
          "SUPER, S, workspace, r+1"
          "SUPER CTRL, A, focusmonitor, l"
          "SUPER CTRL, S, focusmonitor, r"

          # Switch to previous workspace
          "SUPER, Tab, workspace, previous_per_monitor"

          # Move window to workspace
          "SUPER SHIFT, 1, movetoworkspacesilent, 1"
          "SUPER SHIFT, 2, movetoworkspacesilent, 2"
          "SUPER SHIFT, 3, movetoworkspacesilent, 3"
          "SUPER SHIFT, 4, movetoworkspacesilent, 4"
          "SUPER SHIFT, 5, movetoworkspacesilent, 5"
          "SUPER SHIFT, 6, movetoworkspacesilent, 6"
          "SUPER SHIFT, 7, movetoworkspacesilent, 7"
          "SUPER SHIFT, 8, movetoworkspacesilent, 8"
          "SUPER SHIFT, 9, movetoworkspacesilent, 9"
          "SUPER SHIFT, 0, movetoworkspacesilent, 10"

          "SUPER SHIFT, A, movetoworkspacesilent, r-1"
          "SUPER SHIFT, S, movetoworkspacesilent, r+1"

          # Special workspace (scratchpad)
          "SUPER, W, togglespecialworkspace"
          "SUPER SHIFT, W, movetoworkspacesilent, special"

          # Travel workspaces with mouse
          "SUPER, mouse_up, workspace, r+1"
          "SUPER, mouse_down, workspace, r-1"
        ];

        binde = [
          # Resize window
          "SUPER ALT, H, resizeactive, -${resizeStep} 0"
          "SUPER ALT, J, resizeactive, 0 ${resizeStep}"
          "SUPER ALT, K, resizeactive, 0 -${resizeStep}"
          "SUPER ALT, L, resizeactive, ${resizeStep} 0"
        ];

        bindel = [
          # Audio control
          ", XF86AudioRaiseVolume, exec, ${pamixer} -i ${volumeStep} && ${volume-update}"
          ", XF86AudioLowerVolume, exec, ${pamixer} -d ${volumeStep} && ${volume-update}"
        ];

        bindl = [
          # Audio mute
          ", XF86AudioMute, exec, ${pamixer} -t && ${volume-update}"

          # Player control
          ", XF86AudioPlay, exec, ${playerctl} play-pause"
          ", XF86AudioPrev, exec, ${playerctl} previous"
          ", XF86AudioNext, exec, ${playerctl} next"

          # Brightness control
          ", XF86MonBrightnessUp, exec, ${brightnessctl} set 5%+"
          ", XF86MonBrightnessDown, exec, ${brightnessctl} set 5%-"
        ];

        bindm = [
          # Move and resize windows with mouse
          "SUPER, mouse:272, movewindow"
          "SUPER, mouse:273, resizewindow"
        ];

        binds = {
          allow_workspace_cycles = true;
        };
      };
  };
}
