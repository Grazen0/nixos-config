{config, ...}: {
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
      default-layout = "rivertile";
      keyboard-layout = "-options 'grp:alt_shift_toggle,caps:swapescape' 'us,latam'";

      border-width = 3;

      background-color = "0x${colors.background}";
      border-color-focused = "0x${colors.blue}";
      border-color-unfocused = "0x${colors.brightBlack}";
      border-color-urgent = "0x${colors.brightMagenta}";

      set-repeat = "50 300";

      xcursor-theme = let
        inherit (config.theme.home) cursor;
      in "${cursor.name} ${toString cursor.size}";
    };

    extraConfig =
      # bash
      ''
        rivertile -view-padding 6 -outer-padding 3 &
      '';
  };
}
