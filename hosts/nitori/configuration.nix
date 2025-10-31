{ lib', pkgs, ... }:
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
    ../../components/nixos/obs-virtual-camera

    (lib'.mkUserModule {
      username = "jdgt";
      homeManagerModules = [ ./home.nix ];
    })

    ./hardware-configuration.nix
  ];

  programs.nix-ld.enable = true;
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

  virtualisation.docker.rootless.enable = true;

  hardware.nvidia.prime = {
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
    sync.enable = true;
  };

  services.udev.extraRules = ''
    # ST-Link v2 and v2-1 programmer
    ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3748", MODE="0666", GROUP="plugdev"
    ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374b", MODE="0666", GROUP="plugdev"
  '';

  services.udev.packages = [
    (pkgs.writeTextFile {
      name = "xilinx-dilligent-usb-udev";
      destination = "/etc/udev/rules.d/52-xilinx-digilent-usb.rules";
      text = ''
        ATTR{idVendor}=="1443", MODE:="666"
        ACTION=="add", ATTR{idVendor}=="0403", ATTR{manufacturer}=="Digilent", MODE:="666"
      '';
    })
    (pkgs.writeTextFile {
      name = "xilinx-pcusb-udev";
      destination = "/etc/udev/rules.d/52-xilinx-pcusb.rules";
      text = ''
        ATTR{idVendor}=="03fd", ATTR{idProduct}=="0008", MODE="666"
        ATTR{idVendor}=="03fd", ATTR{idProduct}=="0007", MODE="666"
        ATTR{idVendor}=="03fd", ATTR{idProduct}=="0009", MODE="666"
        ATTR{idVendor}=="03fd", ATTR{idProduct}=="000d", MODE="666"
        ATTR{idVendor}=="03fd", ATTR{idProduct}=="000f", MODE="666"
        ATTR{idVendor}=="03fd", ATTR{idProduct}=="0013", MODE="666"
        ATTR{idVendor}=="03fd", ATTR{idProduct}=="0015", MODE="666"
      '';
    })
    (pkgs.writeTextFile {
      name = "xilinx-ftdi-usb-udev";
      destination = "/etc/udev/rules.d/52-xilinx-ftdi-usb.rules";
      text = ''
        ACTION=="add", ATTR{idVendor}=="0403", ATTR{manufacturer}=="Xilinx", MODE:="666"
      '';
    })
  ];

  users.groups.plugdev.members = [ "jdgt" ];

  networking.hostName = "nitori";
  system.stateVersion = "24.05";
}
