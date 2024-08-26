{
  inputs,
  outputs,
  ...
}: {
  nixpkgs = {
    overlays = with outputs.overlays; [
      additions
      modifications
      stable-packages
      inputs.nix-matlab.overlay
    ];

    config.allowUnfree = true;
  };
}
