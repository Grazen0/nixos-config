{
  config,
  lib,
  ...
}: {
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
