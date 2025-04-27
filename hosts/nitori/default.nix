{
  lib,
  pkgs,
  inputs,
  ...
}:
let
  inherit (lib) mkForce;
in
{
  imports = [
    inputs.nixos-hardware.nixosModules.common-gpu-intel
    ./hardware.nix
  ];

  console.font = mkForce "${pkgs.terminus_font}/share/consolefonts/ter-v20b.psf.gz";

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

  services.openssh.settings.AllowUsers = [ "jdgt" ];

  hardware.nvidia.prime = {
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
    sync.enable = true;
  };

  networking.hostName = "nitori";
  system.stateVersion = "24.05";
}
