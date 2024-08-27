{outputs, ...}: {
  imports = [
    outputs.nixosModules
    ./hardware-configuration.nix
    ./modules
  ];

  system.stateVersion = "24.05";
}
