{config, ...}: {
  programs.foot = {
    enable = true;
    server.enable = false;

    settings = let
      inherit (config) theme;
      colors = theme.colors.hex;
    in {
      main = {
        font = "${theme.font.regular}:size=10";
        pad = "4x0";
      };

      colors = with colors; {
        inherit background foreground;

        selection-foreground = white;
        selection-background = highlight;

        regular0 = black;
        regular1 = red;
        regular2 = green;
        regular3 = yellow;
        regular4 = blue;
        regular5 = magenta;
        regular6 = cyan;
        regular7 = white;

        bright0 = brightBlack;
        bright1 = brightRed;
        bright2 = brightGreen;
        bright3 = brightYellow;
        bright4 = brightBlue;
        bright5 = brightMagenta;
        bright6 = brightCyan;
        bright7 = brightWhite;
      };

      mouse.hide-when-typing = "yes";

      cursor.color = with colors; "${background} ${white}";

      scrollback.lines = 10000;
    };
  };
}
