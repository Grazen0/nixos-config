{
  config,
  lib,
  ...
}: {
  programs.foot = {
    enable = true;
    server.enable = false;

    settings = {
      main = {
        font = lib.mkDefault "${config.theme.font.regular}:size=9.5";
      };

      colors = with config.theme.colors.hexNh; {
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

      mouse = {
        hide-when-typing = "yes";
      };
      cursor = {
        color = with config.theme.colors.hexNh; "${background} ${white}";
      };

      scrollback.lines = 10000;
    };
  };
}
