{
  imports = [
    ./nixvim
    ./thunar.nix
    ./zsh.nix
  ];

  programs = {
    dconf.enable = true;
    hyprland.enable = true;
  };
}
