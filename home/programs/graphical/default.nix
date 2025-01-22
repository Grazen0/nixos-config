{
  imports = [
    ./equibop
    ./foot.nix
    ./idea.nix
    ./kitty.nix
    ./mpv.nix
    ./spicetify.nix
    ./swayimg.nix
    ./thunar.nix
    ./touhou.nix
    ./zapzap.nix
    ./zathura.nix
  ];

  programs = {
    obs-studio.enable = true;
  };
}
