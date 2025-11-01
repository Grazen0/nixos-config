{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  programs.yazi = {
    package = inputs.yazi.packages.${pkgs.system}.default;
    shellWrapperName = "y";

    plugins =
      let
        inherit (lib) genAttrs;

        officialPlugins = [
          "full-border"
          "smart-enter"
          "toggle-pane"
          "git"
          "mount"
        ];

        inputPlugins = [ "restore" ];
      in
      (genAttrs officialPlugins (plugin: "${inputs.yazi-plugins}/${plugin}.yazi"))
      // (genAttrs inputPlugins (plugin: inputs."yazi-plugin-${plugin}"));

    settings = {
      mgr = {
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

    keymap.mgr.prepend_keymap = [
      {
        on = "j";
        run = "arrow 1";
      }
      {
        on = "k";
        run = "arrow -1";
      }
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
        on = "<c-n>";
        run = ''
          shell '${pkgs.dragon-drop}/bin/dragon-drop -i -T "$@"' --confirm
        '';
        desc = "Dragon drop";
      }
      {
        on = "M";
        run = "plugin mount";
        desc = "Mount manager";
      }
      {
        on = [
          "g"
          "t"
        ];
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
