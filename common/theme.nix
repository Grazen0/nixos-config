{
  lib,
  lib',
  ...
}: {
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
}
