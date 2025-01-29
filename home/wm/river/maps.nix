{
  config,
  osConfig,
  lib,
  lib',
  pkgs,
  customPkgs,
  ...
}: {
  wayland.windowManager.river.settings = {
    map = let
      inherit (config.mainPrograms) terminal browser fileManager fileManagerCli appLauncher dmenu;
      inherit (lib'.river) tagNumStr spawn withRules;

      grim = "${pkgs.grim}/bin/grim";
      slurp = "${pkgs.slurp}/bin/slurp";
      cliphist = "${config.services.cliphist.package}/bin/cliphist";
      wl-copy = "${pkgs.wl-clipboard}/bin/wl-copy";
      pamixer = "${pkgs.pamixer}/bin/pamixer";
      volume-update = "${customPkgs.volume-update}/bin/volume-update";
      brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
      playerctl = "${pkgs.playerctl}/bin/playerctl";

      uwsmApp = "${osConfig.programs.uwsm.package}/bin/uwsm app --";
      moveStep = "50";
      resizeStep = "50";
      volumeStep = "5";
      brightnessStep = "5%";
    in {
      normal =
        {
          # River control
          "Super+Alt Q" = "exit";

          # Programs
          "Super Return" = spawn "${uwsmApp} ${terminal}";
          "Super+Shift Return" = spawn (withRules "-app-id 'kitty'" ["float" "dimensions 800 450"] "${uwsmApp} ${terminal}");
          "Super E" = spawn "${uwsmApp} ${fileManager}";
          "Super+Shift E" = spawn (withRules "-app-id 'kitty'" ["float" "dimensions 800 450"] "${uwsmApp} ${terminal} ${fileManagerCli}");
          "Super B" = spawn "${uwsmApp} ${browser}";
          "Super O" = spawn "${uwsmApp} ${pkgs.obsidian}/bin/obsidian";

          # Menus
          "Super Space" = spawn "${appLauncher}";
          "Super V" = spawn "${cliphist} list | ${dmenu} | ${cliphist} decode | ${wl-copy}";
          "Super Period" = spawn "${pkgs.bemoji}/bin/bemoji -n -t";
          "Super Comma" = spawn "${uwsmApp} ${customPkgs.menu-qalc}/bin/= --dmenu=fuzzel";
          "Super+Shift X" = spawn "${uwsmApp} ${customPkgs.fuzzel-power-menu}/bin/fuzzel-power-menu";

          # Screen capture
          "None Print" = spawn "pidof -q slurp || ${slurp} -w 0 -b 00000088 | ${grim} -g - - | ${wl-copy}";
          "Shift Print" = spawn "pidof -q slurp || ${slurp} -ro -w 0 -b 00000088 -B 00000088 | ${grim} -g - - | ${wl-copy}";

          # Window controls
          "Super Q" = "close";
          "Super F" = "toggle-fullscreen";
          "Super M" = "send-layout-cmd wideriver '--layout-toggle'";
          "Super T" = "toggle-float";

          # Move view focus
          "Super H" = "focus-view left";
          "Super J" = "focus-view down";
          "Super K" = "focus-view up";
          "Super L" = "focus-view right";

          # Cycle view focus
          "Super C" = "focus-view next";
          "Super+Shift C" = "focus-view previous";

          # Swap views
          "Super+Shift H" = "swap left";
          "Super+Shift J" = "swap down";
          "Super+Shift K" = "swap up";
          "Super+Shift L" = "swap right";

          # Move views
          "Super Left" = "move left ${moveStep}";
          "Super Down" = "move down ${moveStep}";
          "Super Up" = "move up ${moveStep}";
          "Super Right" = "move right ${moveStep}";

          # TODO: Cycle tags

          # Back-and-forth between recent tags
          "Super Tab" = "focus-previous-tags";
          "Super+Shift Tab" = "send-to-previous-tags";

          # Scratchpad
          "Super W" = "toggle-focused-tags 2048";
          "Super+Shift W" = "set-view-tags 2048";

          # Focus next/previous output
          "Super S" = "focus-output next";
          "Super A" = "focus-output previous";

          # Send view to next/previous output
          "Super+Shift S" = "send-to-output -current-tags next";
          "Super+Shift A" = "send-to-output -current-tags previous";

          # Audio control
          "None XF86AudioMute" = spawn "${pamixer} -t && ${volume-update}";

          # Player control
          "None XF86AudioPlay" = spawn "${playerctl} play-pause";
          "None XF86AudioPrev" = spawn "${playerctl} previous";
          "None XF86AudioNext" = spawn "${playerctl} next";
        }
        // lib.zipAttrsWith (_: values: assert (lib.length values == 1); lib.head values) (lib.genList (n: let
            key = toString (n + 1);
            tag = tagNumStr (n + 1);
          in {
            # Focus tag
            "Super ${key}" = "set-focused-tags ${tag}";

            # Send view to tag
            "Super+Shift ${key}" = "set-view-tags ${tag}";

            # Toggle tag
            "Super+Control ${key}" = "toggle-focused-tags ${tag}";

            # Toggle view tags
            "Super+Shift+Control ${key}" = "toggle-view-tags ${tag}";
          })
          9);

      "-repeat".normal = let
        ratioStep = "0.02";
      in {
        # Resize views
        "Super+Alt H" = "resize horizontal -${resizeStep}";
        "Super+Alt J" = "resize vertical ${resizeStep}";
        "Super+Alt K" = "resize vertical -${resizeStep}";
        "Super+Alt L" = "resize horizontal ${resizeStep}";

        # Change split ratios
        "Super I" = "send-layout-cmd wideriver '--ratio +${ratioStep}'";
        "Super U" = "send-layout-cmd wideriver '--ratio -${ratioStep}'";

        # Audio control
        "None XF86AudioRaiseVolume" = spawn "${pamixer} -i ${volumeStep} && ${volume-update}";
        "None XF86AudioLowerVolume" = spawn "${pamixer} -d ${volumeStep} && ${volume-update}";

        # Brightness control
        "None XF86MonBrightnessUp" = spawn "${brightnessctl} set ${brightnessStep}+";
        "None XF86MonBrightnessDown" = spawn "${brightnessctl} set ${brightnessStep}-";
      };
    };

    map-pointer.normal = {
      "Super BTN_LEFT" = "move-view";
      "Super BTN_RIGHT" = "resize-view";
      "Super BTN_MIDDLE" = "toggle-float";
    };
  };
}
