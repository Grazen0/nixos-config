{lib, ...}: {
  font = rec {
    regular = "JetBrainsMonoNL Nerd Font";
    mono = "${regular} Mono";
    propo = "${regular} Propo";
  };

  colors = rec {
    hexNh = rec {
      background = "1f1f28";
      backgroundAlt = "363646";
      foreground = brightWhite;
      highlight = "223249";

      black = "16161d";
      brightBlack = "727169";
      red = "c34043";
      brightRed = "e82424";
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

    hex = lib.mapAttrs (_: color: "#" + color) hexNh;
  };
}
