{ config, pkgs, ... }:
{
  programs.swaylock = {
    package = pkgs.swaylock-effects;

    settings = with config.scheme; {
      font = config.theme.font.regular;

      hide-keyboard-layout = true;
      indicator = true;
      indicator-radius = 100;
      line-uses-inside = true;

      clock = true;
      timestr = "%I:%M %p";
      datestr = "%B %-d, %Y";

      color = base00;
      separator-color = base00;

      key-hl-color = blue;
      bs-hl-color = red;

      inside-color = base00;
      inside-clear-color = base00;
      inside-ver-color = base00;
      inside-wrong-color = base00;

      ring-color = base04;
      ring-clear-color = cyan;
      ring-caps-lock-color = magenta;
      ring-ver-color = yellow;
      ring-wrong-color = red;

      text-color = base05;
      text-clear-color = cyan;
      text-caps-lock-color = magenta;
      text-ver-color = yellow;
      text-wrong-color = red;
    };
  };
}
