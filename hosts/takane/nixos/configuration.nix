{outputs, ...}: {
  imports = [
    outputs.nixosModules
    ./hardware-configuration.nix
  ];

  console.keyMap = "la-latin1";

  system.stateVersion = "24.05";
}
