{
  imports = [
    ./bash.nix
    ./thunar.nix
  ];

  programs = {
    dconf.enable = true;
    hyprland.enable = true;
    steam.enable = true;
  };
}
