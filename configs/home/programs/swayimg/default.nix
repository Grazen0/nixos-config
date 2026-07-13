{ config, ... }:
{
  programs.swayimg = {
    initLua =
      with config.scheme;
      # lua
      ''
        swayimg.enable_antialiasing(true)
        swayimg.enable_decoration(true)
        swayimg.enable_overlay(false)
        swayimg.enable_exif_orientation(true)

        swayimg.viewer.set_default_scale('optimal')
        swayimg.viewer.set_window_background(0xff${base00})

        swayimg.text.set_font('${config.theme.font.propo}')
        swayimg.text.set_size(18)
        swayimg.text.set_foreground(0xff${base05})
        swayimg.text.set_shadow(0xff${base01})

        swayimg.imagelist.enable_adjacent(true)
        swayimg.imagelist.enable_fsmon(true)

        swayimg.text.hide()

        swayimg.viewer.on_key('p', function()
          swayimg.viewer.switch_image('prev')
        end)

        swayimg.viewer.on_key('n', function()
          swayimg.viewer.switch_image('next')
        end)

        swayimg.viewer.on_key('g', function()
          swayimg.viewer.switch_image('first')
        end)

        swayimg.viewer.on_key('Shift+g', function()
          swayimg.viewer.switch_image('last')
        end)

        local step_x = function(dist)
          return function()
            local wnd = swayimg.get_window_size()
            local pos = swayimg.viewer.get_position()
            swayimg.viewer.set_abs_position(math.floor(pos.x + (wnd.width / dist)), pos.y);
          end
        end

        local step_y = function(dist)
          return function()
            local wnd = swayimg.get_window_size()
            local pos = swayimg.viewer.get_position()
            swayimg.viewer.set_abs_position(pos.x, math.floor(pos.y + (wnd.height / dist)));
          end
        end

        swayimg.viewer.on_key("h", step_x(10))
        swayimg.viewer.on_key("j", step_y(-10))
        swayimg.viewer.on_key("k", step_y(10))
        swayimg.viewer.on_key("l", step_x(-10))

        swayimg.viewer.on_key("Shift+k", function()
          local scale = swayimg.viewer.get_scale()
          scale = scale + scale / 10
          swayimg.viewer.set_abs_scale(scale);
        end)

        swayimg.viewer.on_key("Shift+j", function()
          local scale = swayimg.viewer.get_scale()
          scale = scale - scale / 10
          swayimg.viewer.set_abs_scale(scale);
        end)
      '';
  };
}
