{
  imports = [
    ./bash.nix
    ./gnupg.nix
    ./thunar.nix
  ];

  programs = {
    dconf.enable = true;
    fish.enable = true;
    hyprland.withUWSM = true;
    river = {
      enable = true;
      withUWSM = true;
      # Would install waybar, foot and dmenu for some reason
      extraPackages = [];
    };
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };
}
