{
  imports = [
    ./graphical
    ./neovim
    ./bat.nix
    ./btop.nix
    ./cava.nix
    ./direnv.nix
    ./fastfetch.nix
    ./foot.nix
    ./git.nix
    ./peaclock.nix
    ./tmux.nix
    ./yazi.nix
  ];

  programs = {
    broot.enable = true;
    eza.enable = true;
    obs-studio.enable = true;
    lazygit.enable = true;
  };
}
