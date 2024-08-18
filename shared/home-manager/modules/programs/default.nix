{
  imports = [
    ./bat.nix
    ./cava.nix
    ./fastfetch.nix
    ./git.nix
    ./kitty.nix
    ./librewolf.nix
    ./ranger.nix
    ./tmux.nix
    ./zathura.nix
  ];

  programs = {
    eza.enable = true;
    mpv.enable = true;
    obs-studio.enable = true;
    vscode.enable = true;
  };
}
