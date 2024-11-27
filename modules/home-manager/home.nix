{inputs, ...}: {
  home = {
    username = "jdgt";
    homeDirectory = "/home/jdgt";
  };

  nixpkgs = {
    overlays = [
      inputs.self.overlays.additions
      inputs.self.overlays.modifications
      inputs.self.overlays.stable-packages
    ];

    config = import ./nixpkgs-config.nix;
  };

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  xdg.configFile."nixpkgs/config.nix".source = ./nixpkgs-config.nix;

  # Reload system units on switch
  systemd.user.startServices = "sd-switch";
}
