{config, ...}: {
  programs.hyprlock = {
    enable = true;

    settings = with config.theme.colors.hex; {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
        no_fade_in = false;
      };

      background = [
        {
          path = "${config.xdg.userDirs.pictures}/wallpaper.png";
        }
      ];

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

          font_color = "rgb(${brightWhite})";
          inner_color = "rgb(${black})";
          outer_color = "rgb(${blue})";
          check_color = "rgb(${yellow})";
          fail_color = "rgb(${red})";
        }
      ];
    };
  };
}
