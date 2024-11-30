{
  lib,
  theme,
  ...
}: {
  programs.foot = {
    enable = true;
    server.enable = false;

    settings = let
      colors = theme.colors.hexNh;
    in {
      main = {
        font = lib.mkDefault "${theme.font.regular}:size=9.5";
        pad = "4x1 center";
        underline-thickness = 1;
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

        alpha = 0.85;
      };

      mouse.hide-when-typing = "yes";

      cursor.color = with colors; "${background} ${white}";

      scrollback.lines = 10000;
    };
  };
}
