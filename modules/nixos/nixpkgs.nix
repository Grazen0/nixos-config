{
  inputs,
  outputs,
  ...
}: {
  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.stable-packages
      inputs.nix-matlab.overlay
    ];

    config.allowUnfree = true;
  };
}
