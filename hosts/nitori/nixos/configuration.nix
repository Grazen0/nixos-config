{
  pkgs,
  inputs,
  outputs,
  ...
}: {
  imports = [
    outputs.nixosModules
    inputs.nixos-hardware.nixosModules.common-gpu-intel
    ./hardware-configuration.nix
  ];

  console.font = "${pkgs.terminus_font}/share/consolefonts/ter-v20b.psf.gz";

  system.stateVersion = "24.05";
}
