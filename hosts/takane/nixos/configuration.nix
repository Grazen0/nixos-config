{inputs, ...}: {
  imports = [
    inputs.self.nixosModules
    ./hardware-configuration.nix
  ];

  console.keyMap = "la-latin1";

  system.stateVersion = "24.05";
}
