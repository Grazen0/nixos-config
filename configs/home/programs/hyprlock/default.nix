{ config, ... }:
{
  programs.hyprlock = {
    settings = with config.scheme; {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
        no_fade_in = false;
      };

      background = [ { path = config.theme.home.wallpaper.target; } ];

      input-field = [
        {
          monitor = "";
          size = "200, 50";
          position = "0, -160";
          halign = "center";
          valign = "center";

          outline_thickness = 4;
          placeholder_text = "Password...";

          dots_center = true;
          fade_on_empty = true;

          font_color = "rgb(${base05})";
          inner_color = "rgb(${base01})";
          outer_color = "rgb(${blue})";
          check_color = "rgb(${yellow})";
          fail_color = "rgb(${red})";
        }
      ];
    };
  };
}
