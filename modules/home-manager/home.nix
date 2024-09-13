{
  home = {
    username = "jdgt";
    homeDirectory = "/home/jdgt";
  };

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  nixpkgs.config = import ./nixpkgs-config.nix;
  xdg.configFile."nixpkgs/config.nix".source = ./nixpkgs-config.nix;

  # Reload system units on switch
  systemd.user.startServices = "sd-switch";
}
