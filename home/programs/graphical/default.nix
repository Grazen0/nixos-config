{
  imports = [
    ./equibop
    ./foot.nix
    ./jetbrains.nix
    ./kitty.nix
    ./mpv.nix
    ./spicetify.nix
    ./swayimg.nix
    ./thunar.nix
    ./touhou.nix
    ./vscode.nix
    ./zapzap.nix
    ./zathura.nix
  ];

  programs = {
    obs-studio.enable = true;
  };
}
