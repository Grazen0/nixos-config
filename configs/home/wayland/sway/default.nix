{
  config,
  pkgs,
  lib,
  ...
}:
{
  wayland.windowManager.sway = {
    config =
      let
        wbg = "${pkgs.wbg}/bin/wbg";
        waybar = "${pkgs.waybar}/bin/waybar";
        polkit-gnome = "${pkgs.polkit-gnome}/bin/polkit-gnome";
        wl-paste = "${pkgs.wl-clipboard}/bin/wl-paste";
        cliphist = "${config.services.cliphist.package}/bin/cliphist";
        eww = "${config.programs.eww.package}/bin/eww";
      in
      {
        modifier = "Mod1";
        terminal = "foot";
        startup = [
          { command = "${wbg} ${config.theme.home.wallpaper.source}"; }
          { command = waybar; }
          { command = polkit-gnome; }
          { command = "${wl-paste} --watch ${cliphist} store"; }
          { command = "${eww} open-many ${lib.concatStringsSep " " config.meta.eww.autostartWidgets}"; }
        ];
      };
  };

  # See https://nixos.wiki/wiki/Sway
  security.pam.services.swaylock = { };
  security.pam.loginLimits = [
    {
      domain = "@users";
      item = "rtprio";
      type = "-";
      value = 1;
    }
  ];
}
