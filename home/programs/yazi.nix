{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  programs.yazi = {
    enable = true;
    shellWrapperName = "y";

    flavors.kanagawa = inputs.yazi-flavor-kanagawa;
    theme.flavor.use = "kanagawa";

    plugins = let
      inherit (lib) genAttrs;

      official-plugins = [
        "full-border"
        "smart-enter"
        "toggle-pane"
        "git"
        "mount"
      ];

      input-plugins = ["restore"];
    in
      (genAttrs official-plugins (plugin: "${inputs.yazi-plugins}/${plugin}.yazi"))
      // (genAttrs input-plugins (plugin: inputs."yazi-plugin-${plugin}"));

    settings = {
      manager = {
        sort_by = "natural";
        linemode = "size";
      };

      opener.open = [
        {
          run = "xdg-open \"$@\"";
          desc = "Open";
          orphan = true;
        }
      ];

      plugin.prepend_fetchers = [
        {
          id = "git";
          name = "*";
          run = "git";
        }
        {
          id = "git";
          name = "*/";
          run = "git";
        }
      ];
    };

    keymap.manager.prepend_keymap = [
      {
        on = "!";
        run = ''shell "$SHELL" --block --confirm'';
        desc = "Open shell here";
      }
      {
        on = "l";
        run = "plugin smart-enter";
        desc = "Enter the child directory, or open the file";
      }
      {
        on = "T";
        run = "plugin toggle-pane max-preview";
        desc = "Maximize or restore preview";
      }
      {
        on = "u";
        run = "plugin restore";
        desc = "Restore last deleted files/folders";
      }
      {
        on = "<C-n>";
        run = ''
          shell '${pkgs.xdragon}/bin/dragon -i -T "$@"' --confirm
        '';
        desc = "Dragon drop";
      }
      {
        on = "M";
        run = "plugin mount";
        desc = "Mount manager";
      }
      {
        on = ["g" "t"];
        run = "cd ${config.xdg.dataHome}/Trash/files";
        desc = "Goto trash";
      }
    ];

    initLua =
      # lua
      ''
        -- Show user/group of files in status bar
        Status:children_add(function()
          local h = cx.active.current.hovered
          if h == nil or ya.target_family() ~= "unix" then
            return ui.Line {}
          end

          return ui.Line {
            ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
            ui.Span(":"),
            ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
            ui.Span(" "),
          }
        end, 500, Status.RIGHT)

        -- Show username and hostname in header
        Header:children_add(function()
          if ya.target_family() ~= "unix" then
            return ui.Line {}
          end
          return ui.Span(ya.user_name() .. "@" .. ya.host_name() .. ":"):fg("blue")
        end, 500, Header.LEFT)

        require("full-border"):setup()
        require("git"):setup()
      '';
  };
}
