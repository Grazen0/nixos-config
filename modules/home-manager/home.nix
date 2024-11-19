{outputs, ...}: {
  home = {
    username = "jdgt";
    homeDirectory = "/home/jdgt";
  };

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.stable-packages
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
