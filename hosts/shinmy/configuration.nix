{
  config,
  lib,
  lib',
  pkgs,
  ...
}:
{
  imports = [
    ../../options/common
    ../../options/nixos
    ../../configs/nixos

    ../../components/nixos/base
    ../../components/nixos/sops

    (lib'.mkUserModule {
      username = "jdgt";
      homeManagerModules = [ ./home ];
    })

    ./hardware-configuration.nix
    ./services
  ];

  boot.loader.timeout = lib.mkForce 0;

  powerManagement.enable = true;
  powerManagement.cpuFreqGovernor = "ondemand";
  powerManagement.powertop.enable = true;
  services.tlp.enable = true;

  virtualisation.docker.enable = true;
  users.users.jdgt.extraGroups = [ "docker" ];

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [ "jdgt" ];
    };
  };
  services.fail2ban.enable = true;

  users.users.jdgt.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAOkSF7oISnWuVsOxvgZ6JiAx4u/d2+AOXoQW7KAmA3T josedanielgrayson@proton.me"
  ];

  environment.systemPackages =
    with pkgs;
    (lib.optionals config.services.cloudflared.enable [ cloudflared ])
    ++ (lib.optionals config.services.minecraft-server.enable [ mcrcon ])
    ++ (lib.optionals config.services.jellyfin.enable [
      jellyfin
      jellyfin-web
      jellyfin-ffmpeg
    ]);

  networking.firewall.allowedTCPPorts = [
    7777 # Terraria server
    5232
  ];

  networking.hostName = "shinmy";
  system.stateVersion = "24.05";
}
