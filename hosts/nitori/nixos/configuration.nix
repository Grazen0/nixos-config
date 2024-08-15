{hardware, ...}: {
  imports = [
    hardware.common-gpu-intel
    ./hardware-configuration.nix
    ./modules
  ];
}
