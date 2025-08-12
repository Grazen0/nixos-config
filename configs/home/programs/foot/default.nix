{ config, ... }:
{
  programs.foot = {
    server.enable = false;

    settings = with config.scheme; {
      main.font = "${config.theme.font.regular}:size=11.5";

      colors = {
        cursor = "${base00} ${base05}";

        background = base00;
        foreground = base05;

        selection-foreground = base06;
        selection-background = base02;

        regular0 = base01;
        regular1 = red;
        regular2 = green;
        regular3 = yellow;
        regular4 = blue;
        regular5 = magenta;
        regular6 = cyan;
        regular7 = base06;

        bright0 = base04;
        bright1 = bright-red;
        bright2 = bright-green;
        bright3 = yellow;
        bright4 = bright-blue;
        bright5 = bright-magenta;
        bright6 = bright-cyan;
        bright7 = base05;
      };

      mouse.hide-when-typing = "yes";

      scrollback.lines = 10000;
    };
  };
}
