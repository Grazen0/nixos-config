{config, ...}: {
  services.wob = {
    enable = true;

    settings = with config.scheme; {
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

        background_color = base00;
        border_color = base05;
        bar_color = base05;

        overflow_background_color = base01;
        overflow_border_color = base05;
        overflow_bar_color = red;
      };

      "style.muted" = {
        bar_color = base04;
        border_color = base04;
      };
    };
  };
}
