{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-gpu-intel
    ./hardware-configuration.nix
  ];

  networking.hostName = "nitori";

  console.font = "${pkgs.terminus_font}/share/consolefonts/ter-v20b.psf.gz";

  # Multi-monitor TTY fix
  systemd.services.multihead-fbset = {
    enable = true;

    serviceConfig = {
      Type = "forking";
      ExecStart = "${pkgs.fbset}/bin/fbset -xres 1920 -yres 1080";

      TimeoutSec = 0;
      StandardOutput = "tty";
      RemainAfterExit = "yes";
      SysVStartPriority = 99;
    };

    wantedBy = ["multi-user.target"];
  };

  system.stateVersion = "24.05";
}
