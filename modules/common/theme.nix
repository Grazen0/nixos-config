{
  config,
  lib,
  ...
}: {
  # TODO: move this config somewhere else
  config = {
    theme = {
      wallpaper = ../../files/wallpaper.png;

      font.regular = "JetBrainsMonoNL Nerd Font";

      colors = let
        mkColors = hex: {
          inherit hex;
          hexWithHashtag = lib.mapAttrs (_: color: "#${color}") hex;
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
    wallpaper = mkOption {
      type = types.path;
      description = ''
        Path to the image  to use as desktop wallpaper.
      '';
    };

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

    colors = rec {
      hex = rec {
        background = mkOption {type = types.str;};
        backgroundAlt = background;
        foreground = background;
        highlight = background;

        black = background;
        red = background;
        green = background;
        yellow = background;
        blue = background;
        magenta = background;
        cyan = background;
        white = background;

        brightBlack = background;
        brightRed = background;
        brightGreen = background;
        brightYellow = background;
        brightBlue = background;
        brightMagenta = background;
        brightCyan = background;
        brightWhite = background;
      };

      hexWithHashtag = hex;
    };
  };
}
