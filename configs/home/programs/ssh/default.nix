{
  programs.ssh = {
    enableDefaultConfig = false;
    settings = {
      "*" = {
        AddKeysToAgent = "yes";
        ForwardAgent = true;
      };

      "shinmy-lan" = {
        HostName = "192.168.100.99";
        User = "jdgt";
        IdentitiesOnly = true;
        IdentityFile = "~/.ssh/shinmy_auth_id_ed25519";
        SetEnv.TERM = "xterm-kitty";
        RequestTTY = "yes";
        RemoteCommand = "tmux new -A -s main";
      };
      "shinmy" = {
        HostName = "100.93.85.10";
        User = "jdgt";
        IdentitiesOnly = true;
        IdentityFile = "~/.ssh/shinmy_auth_id_ed25519";
        SetEnv.TERM = "xterm-kitty";
        RequestTTY = "yes";
        RemoteCommand = "tmux new -A -s main";
      };
      "shinmy.ocicat-ray.ts.net" = {
        IdentitiesOnly = true;
        IdentityFile = "~/.ssh/shinmy_auth_id_ed25519";
      };
      "nitori" = {
        HostName = "nitori.grazen.xyz";
        User = "jdgt";
        IdentitiesOnly = true;
        IdentityFile = "~/.ssh/nitori_auth_id_ed25519";
      };
      "github.com" = {
        IdentitiesOnly = true;
        IdentityFile = "~/.ssh/github_auth_id_ed25519";
      };
      "gitlab.com" = {
        IdentitiesOnly = true;
        IdentityFile = "~/.ssh/gitlab_auth_id_ed25519";
      };
      "codeberg.org" = {
        IdentitiesOnly = true;
        IdentityFile = "~/.ssh/codeberg_auth_id_ed25519";
      };
    };
  };

  services.ssh-agent.enable = true;
}
