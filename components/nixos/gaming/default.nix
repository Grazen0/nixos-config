{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    steam-run
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
}
