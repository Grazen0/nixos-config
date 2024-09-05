{
  imports = [
    ./bat.nix
    ./btop.nix
    ./cava.nix
    ./fastfetch.nix
    ./git.nix
    ./kitty.nix
    ./ranger.nix
    ./spicetify.nix
    ./tmux.nix
    ./zathura.nix
  ];

  programs = {
    eza.enable = true;
    mpv.enable = true;
    nix-index.enable = true;
    obs-studio.enable = true;
    vscode.enable = true;
  };
}
