{
  config,
  pkgs,
  ...
}: {
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;

    settings = let
      inherit (config) theme;
      colors = theme.colors.hex;
    in {
      font = theme.font.regular;

      hide-keyboard-layout = true;
      indicator = true;
      indicator-radius = 100;
      line-uses-inside = true;

      clock = true;
      timestr = "%I:%M %p";
      datestr = "%B %-d, %Y";

      color = colors.background;
      separator-color = colors.background;

      key-hl-color = colors.blue;
      bs-hl-color = colors.red;

      inside-color = colors.background;
      inside-clear-color = colors.background;
      inside-ver-color = colors.background;
      inside-wrong-color = colors.background;

      ring-color = colors.brightBlack;
      ring-clear-color = colors.cyan;
      ring-caps-lock-color = colors.magenta;
      ring-ver-color = colors.yellow;
      ring-wrong-color = colors.red;

      text-color = colors.foreground;
      text-clear-color = colors.cyan;
      text-caps-lock-color = colors.magenta;
      text-ver-color = colors.yellow;
      text-wrong-color = colors.red;
    };
  };
}
