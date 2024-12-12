{
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

    plugins =
      (lib.genAttrs [
        "full-border"
        "smart-enter"
        "max-preview"
        "git"
        "jump-to-char"
      ] (plugin: "${inputs.yazi-plugins}/${plugin}.yazi"))
      // {
        relative-motions = inputs.yazi-plugin-relative-motions;
      };

    settings = {
      manager = {
        sort_by = "natural";
        linemode = "size";
      };

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

    keymap.manager.prepend_keymap =
      [
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
          run = "plugin max-preview";
          desc = "Maximize or restore preview";
        }
        {
          on = "f";
          run = "plugin jump-to-char";
          desc = "Jump to char";
        }
        {
          on = "<C-n>";
          run = ''
            shell '${pkgs.xdragon}/bin/dragon -i -T "$@"' --confirm
          '';
          desc = "Dragon drop";
        }
      ]
      ++ (
        lib.genList (i: {
          on = toString (i + 1);
          run = "plugin relative-motions --args=${toString (i + 1)}";
          desc = "Move in relative steps";
        })
        10
      );

    initLua = ''
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
