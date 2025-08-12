{ lib', ... }:
{
  imports = [
    ../../options/common
    ../../options/nixos
    ../../configs/nixos

    ../../components/common/theme
    ../../components/nixos/base
    ../../components/nixos/graphical
    ../../components/nixos/laptop
    ../../components/nixos/nvidia

    ./hardware-configuration.nix

    (lib'.mkUserModule {
      username = "jdgt";
      homeManagerModules = [
        ../../options/common
        ../../options/home-manager
        ../../configs/home

        ../../components/common/theme
        ../../components/home/base
        ../../components/home/graphical
        ../../components/home/sops
        ../../components/home/touhou
        ../../components/home/tty

        ./home.nix
      ];
    })
  ];

  programs.steam.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [ "jdgt" ];
    };
  };

  users.users.jdgt.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA3+5X33zUyHXb5HCwe5VhDxus/tsK1gAfCGqJJaZc4b josedanielgrayson@proton.me"
  ];

  services.fail2ban.enable = true;
  services.flatpak.enable = true;
  services.tailscale.enable = true;
  services.zerotierone.enable = true;

  virtualisation.docker.enable = true;

  hardware.nvidia.prime = {
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
    sync.enable = true;
  };

  networking.hostName = "nitori";
  system.stateVersion = "24.05";
}
