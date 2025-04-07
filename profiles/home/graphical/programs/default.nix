{
  imports = [
    ./equibop
    ./firefox
    ./foot.nix
    ./jetbrains.nix
    ./kitty.nix
    ./mpv.nix
    ./rstudio.nix
    ./swayimg.nix
    ./thunar.nix
    ./vscode.nix
    ./zapzap.nix
    ./zathura.nix
  ];

  programs = {
    obs-studio.enable = true;
  };
}
