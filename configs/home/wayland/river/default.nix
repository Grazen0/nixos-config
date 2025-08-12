{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./maps.nix
    ./rules.nix
    ./spawn.nix
  ];

  home.sessionVariables = lib.mkIf config.wayland.windowManager.river.enable {
    MOZ_ENABLE_WAYLAND = "1";
  };

  wayland.windowManager.river = rec {
    package = null; # Let river NixOS module handle this

    settings = with config.scheme; {
      keyboard-layout = "-options 'caps:swapescape' -variant 'altgr-intl' 'us'";

      border-width = 2;

      hide-cursor.timeout = 3000;

      background-color = "0x${base00}";
      border-color-focused = "0x${blue}";
      border-color-unfocused = "0x${base04}";
      border-color-urgent = "0x${orange}";

      set-repeat = "50 300";

      xcursor-theme =
        let
          inherit (config.theme.home) cursor;
        in
        "${cursor.name} ${toString cursor.size}";

      default-layout = "wideriver";
    };

    extraConfig =
      let
        wideriver = "${pkgs.wideriver}/bin/wideriver";
      in
      with config.scheme;
      # bash
      ''
        ${wideriver} \
          --layout left \
          --stack dwindle \
          --layout-alt monocle \
          --count 1 \
          --ratio 0.52 \
          --inner-gaps 12 \
          --outer-gaps 12 \
          --border-width ${toString settings.border-width} \
          --border-width-monocle ${toString settings.border-width} \
          --border-color-focused 0x${blue} \
          --border-color-focused-monocle 0x${yellow} \
          --border-color-unfocused 0x${base04} &

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

      decoration {
        border-radius: 0;
        border: none;
        padding: 0;
        border: 0;
        box-shadow: none;
      }

      decoration:backdrop {
        border-radius: 0;
        border: none;
        box-shadow: none;
      }
    '';
}
