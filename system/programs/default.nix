{
  imports = [
    ./bash.nix
    ./gnupg.nix
    ./thunar.nix
  ];

  programs = {
    dconf.enable = true;
    fish.enable = true;
    hyprland = {
      enable = false;
      withUWSM = true;
    };
    river = {
      enable = true;
      withUWSM = true;
    };
    steam.enable = true;
  };
}
