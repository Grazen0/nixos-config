{config, ...}: {
  programs.ssh = {
    enable = true;
    forwardAgent = true;
    extraConfig = ''
      AddKeysToAgent yes
    '';

    matchBlocks = let
      inherit (config.home) homeDirectory;
    in {
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
