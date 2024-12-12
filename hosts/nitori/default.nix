{
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-gpu-intel
    ./hardware-configuration.nix
  ];

  console.font = lib.mkForce "${pkgs.terminus_font}/share/consolefonts/ter-v20b.psf.gz";

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

  services.postgresql = {
    enable = true;
    ensureDatabases = ["testing"];
    enableTCPIP = true;
    # port = 5432;
    authentication = pkgs.lib.mkOverride 10 ''
      #...
      #type database DBuser origin-address auth-method
      local all       all     trust
      # ipv4
      host  all      all     127.0.0.1/32   trust
      # ipv6
      host all       all     ::1/128        trust
    '';
    initialScript = pkgs.writeText "backend-initScript" ''
      CREATE ROLE admin WITH LOGIN PASSWORD 'admin' CREATEDB;
      CREATE DATABASE testing;
      GRANT ALL PRIVILEGES ON DATABASE testing TO admin;
    '';
  };

  home-manager.users.jdgt.imports = [./home.nix];

  system.stateVersion = "24.05";
}
