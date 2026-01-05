{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./binds.nix
    ./rules.nix
  ];

  home.sessionVariables = lib.mkIf config.wayland.windowManager.hyprland.enable {
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  wayland.windowManager.hyprland =
    let
      inherit (config) scheme;
    in
    {
      package = null; # Let the NixOS module handle this

      xwayland.enable = true;
      systemd.enable = false; # Conflicts with UWSM

      settings = {
        monitor = [ ", preferred, auto, 1" ];

        ecosystem = {
          no_update_news = true;
          no_donation_nag = true;
        };

        workspace = [
          "1, monitor:eDP-1, persistent:true, default:true"
          "2, monitor:eDP-1, persistent:true"
          "3, monitor:eDP-1, persistent:true"
          "4, monitor:eDP-1, persistent:true"
          "5, monitor:eDP-1, persistent:true"
          "6, monitor:HDMI-A-1, persistent:true, default:true"
          "7, monitor:HDMI-A-1, persistent:true"
          "8, monitor:HDMI-A-1, persistent:true"
          "9, monitor:HDMI-A-1, persistent:true"
          "10, monitor:HDMI-A-1, persistent:true"
        ];

        general = {
          gaps_in = 5;
          gaps_out = 10;
          border_size = 2;

          "col.active_border" = "rgb(${scheme.blue})";
          "col.inactive_border" = "rgb(${scheme.base04})";

          no_focus_fallback = true;
          allow_tearing = true;
        };

        exec-once =
          let
            inherit (lib) concatStringsSep;
            uwsmApp = "uwsm app --";

            waybar = "${config.programs.waybar.package}/bin/waybar";
            wbg = "${pkgs.wbg}/bin/wbg";
            polkit-gnome = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
            wl-paste = "${pkgs.wl-clipboard}/bin/wl-paste";
            cliphist = "${config.services.cliphist.package}/bin/cliphist";
            eww = "${config.programs.eww.package}/bin/eww";
          in
          [
            "${uwsmApp} ${wbg} ${config.theme.home.wallpaper.source}"
            "${uwsmApp} ${waybar}"
            "${uwsmApp} ${eww} open-many ${concatStringsSep " " config.meta.eww.autostartWidgets}"
            "${uwsmApp} ${polkit-gnome}"
            "${uwsmApp} ${wl-paste} --watch ${cliphist} store"

            "[workspace 7 silent] ${uwsmApp} equibop --start-minimized"
          ];

        dwindle = {
          force_split = 2; # Split to the bottom right
          preserve_split = true;
          default_split_ratio = 1.04;
        };

        decoration = {
          rounding = 0;
          shadow.enabled = false;
          blur.enabled = false;
        };

        animations.enabled = false;

        xwayland.force_zero_scaling = true;

        input = {
          kb_layout = "us";
          kb_variant = "altgr-intl";
          kb_options = "caps:swapescape,altwin:swap_lalt_lwin";

          follow_mouse = 2;
          float_switch_override_focus = 0;

          touchpad.natural_scroll = true;

          repeat_rate = 50;
          repeat_delay = 300;
        };

        cursor = {
          no_hardware_cursors = true; # Nvidia thing
          no_warps = true;
        };

        gestures = {
          workspace_swipe_forever = true;
          workspace_swipe_min_speed_to_force = 7;
        };

        device = [
          {
            name = "wacom-one-by-wacom-s-pen";
            output = "eDP-1";
          }
        ];

        misc = {
          disable_hyprland_logo = true;
          middle_click_paste = false;
          mouse_move_focuses_monitor = false;
          focus_on_activate = true;
          vrr = 1;
        };
      };

      systemd.variables = [ "--all" ];
    };
}
