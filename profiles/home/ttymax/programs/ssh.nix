{ config, pkgs, ... }:
{
  programs.ssh = {
    enable = true;
    forwardAgent = true;
    addKeysToAgent = "yes";

    matchBlocks =
      let
        inherit (config.home) homeDirectory;
      in
      {
        "shinmy-lan" = {
          hostname = "192.168.100.99";
          user = "jdgt";
          identitiesOnly = true;
          identityFile = "${homeDirectory}/.ssh/shinmy_auth_id_ed25519";
        };

        "shinmy" = {
          proxyCommand = "${pkgs.cloudflared}/bin/cloudflared access ssh --hostname %h";
          hostname = "shinmy.unilife.lat";
          user = "jdgt";
          identitiesOnly = true;
          identityFile = "${homeDirectory}/.ssh/shinmy_auth_id_ed25519";
        };

        "github.com" = {
          identitiesOnly = true;
          identityFile = "${homeDirectory}/.ssh/github_auth_id_ed25519";
        };
        "gitlab.com" = {
          identitiesOnly = true;
          identityFile = "${homeDirectory}/.ssh/gitlab_auth_id_ed25519";
        };
        "codeberg.com" = {
          identitiesOnly = true;
          identityFile = "${homeDirectory}/.ssh/codeberg_auth_id_ed25519";
        };
      };
  };

  services.ssh-agent.enable = true;
}
