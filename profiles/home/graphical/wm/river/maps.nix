{
  config,
  lib,
  lib',
  pkgs,
  customPkgs,
  inputs,
  ...
}: {
  wayland.windowManager.river.settings = let
    inherit (lib) mergeAttrsList genList;
    inherit (lib'.river) tagNum tagNumStr spawn;
    inherit (lib') pow;
    inherit (config.meta.mainPrograms) terminal browser fileManager fileManagerCli appLauncher dmenu;

    uwsmApp = "uwsm app --";

    grim = "${pkgs.grim}/bin/grim";
    slurp = "${pkgs.slurp}/bin/slurp";
    cliphist = "${config.services.cliphist.package}/bin/cliphist";
    wl-copy = "${pkgs.wl-clipboard}/bin/wl-copy";
    pamixer = "${pkgs.pamixer}/bin/pamixer";
    volume-update = "${customPkgs.volume-update}/bin/volume-update";
    brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
    playerctl = "${pkgs.playerctl}/bin/playerctl -p mopidy,spotify";
    river-shifttags = "${inputs.river-shifttags.packages.${pkgs.system}.default}/bin/river-shifttags";
    fuzzel-power-menu = "${customPkgs.fuzzel-power-menu}/bin/fuzzel-power-menu";
    menu-qalc = "${customPkgs.menu-qalc}/bin/=";
    bemoji = "${pkgs.bemoji}/bin/bemoji";

    moveStep = "50";
    resizeStep = "50";
    volumeStep = "5";
    brightnessStep = "5%";

    scratchpadTag = tagNum 10;
  in {
    spawn-tagmask = (pow 2 32) - 1 - scratchpadTag;

    map = {
      normal =
        {
          # River control
          "Super+Ctrl+Alt Q" = "exit";

          # Programs
          "Super Return" = spawn "${uwsmApp} ${terminal}";
          "Super+Shift Return" = spawn "${uwsmApp} ${terminal} --app-id=foot-float";
          "Super E" = spawn "${uwsmApp} ${fileManager}";
          "Super+Shift E" = spawn "${uwsmApp} ${terminal} --app-id=foot-float -- ${fileManagerCli}";
          "Super B" = spawn "${uwsmApp} ${browser}";
          "Super O" = spawn "${uwsmApp} obsidian";

          # Menus
          "Super Space" = spawn "${appLauncher}";
          "Super V" = spawn "${cliphist} list | ${dmenu} | ${cliphist} decode | ${wl-copy}";
          "Super Period" = spawn "${bemoji} -n -t";
          "Super Comma" = spawn "${uwsmApp} ${menu-qalc} --dmenu=fuzzel";
          "Super+Shift X" = spawn "${uwsmApp} ${fuzzel-power-menu}";

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

          # Send view to next/previous tag
          "Super+Shift S" = spawn "${river-shifttags} --view --shifts 1";
          "Super+Shift A" = spawn "${river-shifttags} --view --shifts -1";

          # Back-and-forth between recent tags
          "Super Tab" = "focus-previous-tags";
          "Super+Shift Tab" = "send-to-previous-tags";

          # Scratchpad
          "Super 0" = "toggle-focused-tags ${toString scratchpadTag}";
          "Super+Shift 0" = "set-view-tags ${toString scratchpadTag}";

          # Focus next/previous output
          "Super+Control S" = "focus-output next";
          "Super+Control A" = "focus-output previous";

          # Send view to next/previous output
          "Super+Control+Shift S" = "send-to-output -current-tags next";
          "Super+Control+Shift A" = "send-to-output -current-tags previous";

          # Audio control
          "None XF86AudioMute" = spawn "${pamixer} -t && ${volume-update}";

          # Player control
          "None XF86AudioPlay" = spawn "${playerctl} play-pause";
          "None XF86AudioPrev" = spawn "${playerctl} previous";
          "None XF86AudioNext" = spawn "${playerctl} next";
        }
        // mergeAttrsList (genList (n: let
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
        # Move views
        "Super Left" = "move left ${moveStep}";
        "Super Down" = "move down ${moveStep}";
        "Super Up" = "move up ${moveStep}";
        "Super Right" = "move right ${moveStep}";

        # Resize views
        "Super+Alt Left" = "resize horizontal -${resizeStep}";
        "Super+Alt Down" = "resize vertical ${resizeStep}";
        "Super+Alt Up" = "resize vertical -${resizeStep}";
        "Super+Alt Right" = "resize horizontal ${resizeStep}";

        # Change split ratios
        "Super I" = "send-layout-cmd wideriver '--ratio +${ratioStep}'";
        "Super U" = "send-layout-cmd wideriver '--ratio -${ratioStep}'";

        # Cycle tags
        "Super S" = spawn "${river-shifttags} --shifts 1";
        "Super A" = spawn "${river-shifttags} --shifts -1";

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
