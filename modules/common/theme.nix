{
  config,
  lib,
  lib',
  ...
}: {
  # TODO: move this config somewhere else
  config = {
    theme = {
      font.regular = "CommitMono Nerd Font";

      colors = let
        mkColors = hexColors: {
          hex = hexColors;
          hexWithHashtag = lib.mapAttrs (_: hexStr: "#${hexStr}") hexColors;
          rgb = lib.mapAttrs (_: hexStr: lib'.hexToRGB hexStr) hexColors;
        };
      in
        mkColors rec {
          background = "1f1f28";
          backgroundAlt = "363646";
          foreground = brightWhite;
          highlight = "223249";

          black = "16161d";
          red = "c34043";
          green = "76946a";
          yellow = "c0a36e";
          blue = "7e9cd8";
          magenta = "957fb8";
          cyan = "6a9589";
          white = "c8c093";

          brightBlack = "727169";
          brightRed = "e82424";
          brightGreen = "98bb6c";
          brightYellow = "e6c384";
          brightBlue = "7fb4ca";
          brightMagenta = "938aa9";
          brightCyan = "7aa89f";
          brightWhite = "dcd7ba";
        };
    };
  };

  options.theme = let
    inherit (lib) mkOption types;
    inherit (config) theme;
  in {
    font = {
      regular = mkOption {type = types.str;};
      mono = mkOption {
        type = types.str;
        default = "${theme.font.regular} Mono";
      };
      propo = mkOption {
        type = types.str;
        default = "${theme.font.regular} Propo";
      };
    };

    colors = let
      mkColorsOption = colorOption: {
        background = colorOption;
        backgroundAlt = colorOption;
        foreground = colorOption;
        highlight = colorOption;

        black = colorOption;
        red = colorOption;
        green = colorOption;
        yellow = colorOption;
        blue = colorOption;
        magenta = colorOption;
        cyan = colorOption;
        white = colorOption;

        brightBlack = colorOption;
        brightRed = colorOption;
        brightGreen = colorOption;
        brightYellow = colorOption;
        brightBlue = colorOption;
        brightMagenta = colorOption;
        brightCyan = colorOption;
        brightWhite = colorOption;
      };
    in {
      hex = mkColorsOption (mkOption {type = types.str;});
      hexWithHashtag = mkColorsOption (mkOption {type = types.str;});
      rgb = mkColorsOption (mkOption {
        type = with types; listOf ints.u8;
      });
      # rgbString = mkColorsOption {type = types.str;};
    };
  };
}
