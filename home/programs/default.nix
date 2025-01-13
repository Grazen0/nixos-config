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
    ./git.nix
    ./peaclock.nix
    ./r.nix
    ./tmux.nix
    ./yazi.nix
    ./zsh.nix
  ];

  programs = {
    eza.enable = true;
    fd.enable = true;
    lazygit.enable = true;
    ripgrep.enable = true;
    tealdeer.enable = true;
  };
}
