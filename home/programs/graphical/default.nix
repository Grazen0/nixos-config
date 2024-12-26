{
  imports = [
    ./equibop
    ./idea.nix
    ./mpv.nix
    ./spicetify.nix
    ./swayimg.nix
    ./touhou.nix
    ./zapzap.nix
    ./zathura.nix
  ];

  programs = {
    obs-studio.enable = true;
  };
}
