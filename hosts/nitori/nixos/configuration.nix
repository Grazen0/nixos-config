{
  inputs,
  outputs,
  ...
}: {
  imports = [
    outputs.nixosModules
    inputs.nixos-hardware.nixosModules.common-gpu-intel
    ./hardware-configuration.nix
    ./modules
  ];

  system.stateVersion = "24.05";
}
