{
  imports = [
    ./bat.nix
    ./btop.nix
    ./cava.nix
    ./fastfetch.nix
    ./git.nix
    ./kitty.nix
    ./obs-studio.nix
    ./ranger.nix
    ./tmux.nix
    ./zathura.nix
  ];

  programs = {
    eza.enable = true;
    nix-index.enable = true;
    mpv.enable = true;
    vscode.enable = true;
  };
}
