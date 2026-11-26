{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ./binds.nix ];

  home.sessionVariables = lib.mkIf config.wayland.windowManager.hyprland.enable {
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  wayland.windowManager.hyprland = {
    package = null; # Let the NixOS module handle this
    configType = "lua";

    # Home Manager loads these before settings, so host overrides apply last.
    extraLuaFiles = {
      settings = ./settings.lua;
      binds = ./binds.lua;
      rules = ./rules.lua;
      theme = {
        autoLoad = false;
        content = "return ${
          lib.generators.toLua { } {
            inherit (config.scheme) blue base04 yellow;
          }
        }";
      };
    };

    settings = {
      monitor = [
        {
          output = "";
          mode = "preferred";
          position = "auto";
          scale = 1;
        }
      ];

      on = [
        {
          _args = [
            "hyprland.start"
            (lib.generators.mkLuaInline ''
              function()
                for _, command in ipairs(${
                  lib.generators.toLua { } [
                    "${pkgs.wbg}/bin/wbg ${config.theme.home.wallpaper.source}"
                    "${config.programs.waybar.package}/bin/waybar"
                    "${config.programs.eww.package}/bin/eww open-many ${lib.concatStringsSep " " config.meta.eww.autostartWidgets}"
                    "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
                    "${pkgs.wl-clipboard}/bin/wl-paste --watch ${config.services.cliphist.package}/bin/cliphist store"
                  ]
                }) do
                  hl.exec_cmd(command)
                end
              end
            '')
          ];
        }
      ];
    };

    systemd.variables = [ "--all" ];
  };
}
