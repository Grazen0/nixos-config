{inputs, ...}: {
  nixpkgs = {
    overlays = [
      inputs.self.overlays.additions
      inputs.self.overlays.modifications
      inputs.self.overlays.stable-packages
    ];

    config.allowUnfree = true;
  };
}
