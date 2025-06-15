{ config, ... }:
{
  programs.swayimg = {
    enable = true;

    settings = with config.scheme.withHashtag; {
      viewer = {
        window = base01;
        scale = "fit";
        antialiasing = "bicubic";
      };

      list.all = "yes";

      gallery = {
        window = base00;
        antialiasing = "mks13";
      };

      font = {
        name = config.theme.font.propo;
        size = 18;
        color = base05;
        shadow = base01;
      };

      info.show = "no";

      "keys.viewer" = {
        p = "prev_file";
        n = "next_file";

        g = "first_file";
        "Shift+g" = "last_file";

        h = "step_left 10";
        j = "step_down 10";
        k = "step_up 10";
        l = "step_right 10";

        "Shift+j" = "zoom -10";
        "Shift+k" = "zoom +10";
      };

      "keys.gallery" = {
        g = "first_file";
        "Shift+g" = "last_file";

        h = "step_left";
        j = "step_down";
        k = "step_up";
        l = "step_right";

        "Shift+j" = "page_down";
        "Shift+k" = "page_up";
      };
    };
  };
}
