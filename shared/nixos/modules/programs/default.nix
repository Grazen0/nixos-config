{
  imports = [
    ./nixvim
    ./thunar.nix
  ];

  programs = {
    zsh.enable = true;
    hyprland.enable = true;
  };
}
