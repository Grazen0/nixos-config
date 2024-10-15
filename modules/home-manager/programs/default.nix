{
  imports = [
    ./nvf
    ./vesktop
    ./bat.nix
    ./btop.nix
    ./cava.nix
    ./direnv.nix
    ./fastfetch.nix
    ./foot.nix
    ./git.nix
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
