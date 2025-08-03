{
  inputs,
  ...
}:
{
  imports = [
    inputs.nixos-hardware.nixosModules.common-gpu-intel
    ./hardware-configuration.nix
  ];

  # i got arch btw
  boot.loader.systemd-boot.extraEntries = {
    "arch.conf" = ''
      title Arch Linux
      linux /vmlinuz-linux
      initrd /initramfs-linux.img
      options root=UUID=5d240961-a79a-44f2-8827-ef1cf8aa4e1b rw quiet
    '';

    "arch-fallback.conf" = ''
      title Arch Linux (fallback initramfs)
      linux /vmlinuz-linux
      initrd /initramfs-linux-fallback.img
      options root=UUID=5d240961-a79a-44f2-8827-ef1cf8aa4e1b rw quiet
    '';
  };

  services.flatpak.enable = true;

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
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA3+5X33zUyHXb5HCwe5VhDxus/tsK1gAfCGqJJaZc4b josedanielgrayson@proton.me"
  ];

  hardware.nvidia.prime = {
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
    sync.enable = true;
  };

  networking.hostName = "nitori";
  system.stateVersion = "24.05";
}
