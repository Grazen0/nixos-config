{config, ...}: {
  imports = [
    ./neovim
    ./vesktop
    ./bat.nix
    ./btop.nix
    ./cava.nix
    ./direnv.nix
    ./fastfetch.nix
    ./foot.nix
    ./git.nix
    ./idea.nix
    ./mpv.nix
    ./peaclock.nix
    ./spicetify.nix
    ./swayimg.nix
    ./tmux.nix
    ./yazi.nix
    ./zapzap.nix
    ./zathura.nix
  ];

  programs = {
    broot.enable = true;
    eza.enable = true;
    obs-studio.enable = true;
    lazygit.enable = true;
  };
}
