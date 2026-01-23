{
  programs.ssh = {
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        addKeysToAgent = "yes";
        forwardAgent = true;
      };

      "shinmy-lan" = {
        hostname = "192.168.100.99";
        user = "jdgt";
        identitiesOnly = true;
        identityFile = "~/.ssh/shinmy_auth_id_ed25519";
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
        identityFile = "~/.ssh/shinmy_auth_id_ed25519";
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
        identityFile = "~/.ssh/nitori_auth_id_ed25519";
      };
      "github.com" = {
        identitiesOnly = true;
        identityFile = "~/.ssh/github_auth_id_ed25519";
      };
      "gitlab.com" = {
        identitiesOnly = true;
        identityFile = "~/.ssh/gitlab_auth_id_ed25519";
      };
      "codeberg.org" = {
        identitiesOnly = true;
        identityFile = "~/.ssh/codeberg_auth_id_ed25519";
      };
    };
  };

  services.ssh-agent.enable = true;
}
