{
  config,
  lib',
  pkgs,
  customPkgs,
  ...
}:
{
  services.swayidle =
    let
      inherit (lib') timeStrToSecs;
      systemctl = "${pkgs.systemd}/bin/systemctl";
      swaylock = "${config.programs.swaylock.package}/bin/swaylock";
      brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
      wlr-randr-all = "${customPkgs.wlr-randr-all}/bin/wlr-randr-all";
      kanshictl = "${config.services.kanshi.package}/bin/kanshictl";
    in
    {
      enable = true;

      timeouts = [
        {
          # Reduce monitor brightness
          timeout = timeStrToSecs "5m";
          command = "${brightnessctl} -s set 15%";
          resumeCommand = "${brightnessctl} -r";
        }
        {
          # Lock screen
          timeout = timeStrToSecs "10m";
          command = "${swaylock} -fF";
        }
        {
          # Screen off
          timeout = timeStrToSecs "10m 30s";
          command = "${wlr-randr-all} --off";
          resumeCommand = "${kanshictl} reload";
        }
        {
          # Suspend
          timeout = timeStrToSecs "30m";
          command = "${systemctl} suspend";
        }
      ];

      events = [
        {
          event = "before-sleep";
          command = "${swaylock} -f";
        }
        {
          event = "lock";
          command = "${swaylock} -f";
        }
      ];
    };
}
