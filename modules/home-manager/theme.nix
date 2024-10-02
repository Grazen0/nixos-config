{lib, ...}: {
  options = let
    inherit (lib) types mkOption;
  in {
    theme = let
      mkStrOption = extra_opts: mkOption extra_opts // {type = types.str;};
    in {
      font = {
        regular = mkStrOption {};
        mono = mkStrOption {};
        propo = mkStrOption {};
      };

      colors = rec {
        hex = {
          background = mkStrOption {};
          backgroundAlt = mkStrOption {};
          highlight = mkStrOption {};

          black = mkStrOption {};
          brightBlack = mkStrOption {};
          red = mkStrOption {};
          brighRed = mkStrOption {};
          green = mkStrOption {};
          brightGreen = mkStrOption {};
          yellow = mkStrOption {};
          brightYellow = mkStrOption {};
          blue = mkStrOption {};
          brightBlue = mkStrOption {};
          magenta = mkStrOption {};
          brightMagenta = mkStrOption {};
          cyan = mkStrOption {};
          brightCyan = mkStrOption {};
          white = mkStrOption {};
          brightWhite = mkStrOption {};
        };

        hexNh = hex;
      };
    };
  };

  config = {
    theme = {
      font = rec {
        regular = "JetBrainsMonoNL Nerd Font";
        mono = "${regular} Mono";
        propo = "${regular} Propo";
      };

      colors = rec {
        hexNh = {
          background = "1f1f28";
          backgroundAlt = "363646";
          highlight = "223249";

          black = "16161d";
          brightBlack = "727169";
          red = "c34043";
          brighRed = "e82424";
          green = "76946a";
          brightGreen = "98bb6c";
          yellow = "c0a36e";
          brightYellow = "e6c384";
          blue = "7e9cd8";
          brightBlue = "7fb4ca";
          magenta = "957fb8";
          brightMagenta = "938aa9";
          cyan = "6a9589";
          brightCyan = "7aa89f";
          white = "c8c093";
          brightWhite = "dcd7ba";
        };

        hex = builtins.mapAttrs (_: color: "#" + color) hexNh;
      };
    };
  };
}
