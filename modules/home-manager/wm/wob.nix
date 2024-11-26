{theme, ...}: {
  services.wob = {
    enable = true;

    settings = let
      colors = theme.colors.hexNh;
    in {
      "" = {
        timeout = 750;

        orientation = "vertical";
        anchor = "right";

        width = 32;
        height = 200;

        border_offset = 6;
        border_size = 3;
        margin = 30;

        bar_padding = 4;

        background_color = colors.black;
        border_color = colors.brightWhite;
        bar_color = colors.brightWhite;

        overflow_background_color = colors.black;
        overflow_border_color = colors.brightWhite;
        overflow_bar_color = colors.red;
      };

      "style.muted" = {
        bar_color = colors.brightBlack;
        border_color = colors.brightBlack;
      };
    };
  };
}
