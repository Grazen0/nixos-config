{
  imports = [
    ./nixvim
    ./vesktop
    ./bat.nix
    ./btop.nix
    ./cava.nix
    ./fastfetch.nix
    ./git.nix
    ./kitty.nix
    ./matlab.nix
    ./mpv.nix
    ./peaclock.nix
    ./ranger.nix
    ./spicetify.nix
    ./tmux.nix
    ./zapzap.nix
    ./zathura.nix
  ];

  programs = {
    broot.enable = true;
    eza.enable = true;
    obs-studio.enable = true;
  };
}
