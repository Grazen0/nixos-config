{inputs, ...}: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-gpu-intel
    ./hardware-configuration.nix
    ./modules
  ];
}
