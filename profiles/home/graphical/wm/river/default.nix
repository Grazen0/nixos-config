{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./maps.nix
    ./rules.nix
    ./spawn.nix
  ];

  wayland.windowManager.river = {
    enable = true;
    package = null; # Let river NixOS module handle this

    settings = let
      colors = config.theme.colors.hex;
    in {
      keyboard-layout = "-options 'caps:swapescape' -variant 'altgr-intl' 'us'";

      border-width = 3;

      background-color = "0x${colors.background}";
      border-color-focused = "0x${colors.blue}";
      border-color-unfocused = "0x${colors.brightBlack}";
      border-color-urgent = "0x${colors.brightMagenta}";

      set-repeat = "50 300";

      xcursor-theme = let
        inherit (config.theme.home) cursor;
      in "${cursor.name} ${toString cursor.size}";

      default-layout = "wideriver";
    };

    extraConfig = let
      wideriver = "${pkgs.wideriver}/bin/wideriver";
      colors = config.theme.colors.hex;
    in
      # bash
      ''
        ${wideriver} \
          --layout left \
          --stack dwindle \
          --layout-alt monocle \
          --count 1 \
          --ratio 0.52 \
          --inner-gaps 4 \
          --outer-gaps 4 \
          --border-width 3 \
          --border-width-monocle 3 \
          --border-color-focused 0x${colors.blue} \
          --border-color-focused-monocle 0x${colors.yellow} \
          --border-color-unfocused 0x${colors.brightBlack} &

        # Set up touchpads
        for device in $(riverctl list-inputs | grep -i 'touchpad'); do
            riverctl input "$device" natural-scroll enabled
            riverctl input "$device" tap enabled
            riverctl input "$device" click-method button-areas
            riverctl input "$device" middle-emulation enabled
        done
      '';
  };

  # Disable ugly GTK header
  gtk.gtk3.extraCss =
    # css
    ''
      /* No (default) title bar on wayland */
      headerbar.default-decoration {
        /* You may need to tweak these values depending on your GTK theme */
        margin-bottom: 50px;
        margin-top: -100px;
      }

      /* rm -rf window shadows */
      window.csd,             /* gtk4? */
      window.csd decoration { /* gtk3 */
        box-shadow: none;
      }
    '';
}
