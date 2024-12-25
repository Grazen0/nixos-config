{
  imports = [
    ./fish
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
    ./zsh.nix
  ];

  programs = {
    eza.enable = true;
    lazygit.enable = true;
    tealdeer.enable = true;
  };
}
