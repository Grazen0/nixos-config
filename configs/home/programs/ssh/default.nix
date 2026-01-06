{ config, ... }:
{
  programs.ssh = {
    enableDefaultConfig = false;
    matchBlocks =
      let
        inherit (config.home) homeDirectory;
      in
      {
        "*" = {
          addKeysToAgent = "yes";
          forwardAgent = true;
        };

        "shinmy-lan" = {
          hostname = "192.168.100.99";
          user = "jdgt";
          identitiesOnly = true;
          identityFile = "${homeDirectory}/.ssh/shinmy_auth_id_ed25519";
          setEnv.TERM = "xterm-kitty";
          extraOptions = {
            RequestTTY = "yes";
            RemoteCommand = "tmux new -A -s main";
          };
        };
        "shinmy" = {
          hostname = "100.93.85.10";
          user = "jdgt";
          identitiesOnly = true;
          identityFile = "${homeDirectory}/.ssh/shinmy_auth_id_ed25519";
          setEnv.TERM = "xterm-kitty";
          extraOptions = {
            RequestTTY = "yes";
            RemoteCommand = "tmux new -A -s main";
          };
        };
        "nitori" = {
          hostname = "nitori.unilife.lat";
          user = "jdgt";
          identitiesOnly = true;
          identityFile = "${homeDirectory}/.ssh/nitori_auth_id_ed25519";
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
        "gitea.grazen.xyz" = {
          identitiesOnly = true;
          identityFile = "${homeDirectory}/.ssh/gitea_auth_id_ed25519";
        };
      };
  };

  services.ssh-agent.enable = true;
}
