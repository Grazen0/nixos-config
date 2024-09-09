{config, ...}: {
  programs.hyprlock = {
    enable = true;
    settings = {
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

          font_color = "rgb(dcd7ba)";
          inner_color = "rgb(16161d)";
          outer_color = "rgb(a3d4d5)";
          check_color = "rgb(ffa066)";
          fail_color = "rgb(e82424)";

          shadow_passes = 1;
          shadow_color = "rgb(16161d)";
        }
      ];
    };
  };
}
