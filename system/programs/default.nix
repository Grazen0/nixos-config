{
  imports = [
    ./bash.nix
    ./thunar.nix
  ];

  programs = {
    dconf.enable = true;
    fish.enable = true;
    hyprland = {
      enable = true;
      withUWSM = true;
    };
    steam.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}
