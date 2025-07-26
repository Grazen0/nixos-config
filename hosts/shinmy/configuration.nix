{ config, lib, pkgs, ... }:
  let
    inherit (lib) mkForce;
  in
{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.firewall.allowedTCPPorts = [ 3000 80 443 2283 ];

  boot.loader.timeout = mkForce 0;

  programs.neovim.enable = true;

  environment.systemPackages = with pkgs; [
    cloudflared
  ];

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [ "jdgt" ];
    };
  };

  services.immich = {
    enable = true;
    port = 2283;
    openFirewall = true;
    host = "127.0.0.1";
  };

  services.cloudflared = {
    enable = true;
    tunnels."dd024d94-7349-4dd3-889f-7c22987e8097" = {
      credentialsFile = "/var/lib/cloudflared/dd024d94-7349-4dd3-889f-7c22987e8097.json";
      ingress = {
        "shinmy.unilife.lat" = "ssh://localhost:22";
        "overleaf.unilife.lat" = "http://localhost:8080";
        "immich.unilife.lat" = "http://localhost:2283";
      };
      default = "http_status:404";
    };
  };

  users.users.jdgt.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAOkSF7oISnWuVsOxvgZ6JiAx4u/d2+AOXoQW7KAmA3T josedanielgrayson@proton.me"
  ];

  services.fail2ban.enable = true;

  services.minecraft-server = {
    enable = false;
    eula = true;

    openFirewall = true; 
    declarative = true;

    serverProperties = {
      difficulty = 2;
      max-players = 5;
      motd = "NixOS Minecraft server!";
    };
    jvmOpts = "-Xms4G -Xmx4G -XX:ParallelGCThreads=2 -XX:MinHeapFreeRatio=5 -XX:MaxHeapFreeRatio=10";
  };

  virtualisation.docker.enable = true;


  networking.hostName = "shinmy";
  system.stateVersion = "24.05";
}
