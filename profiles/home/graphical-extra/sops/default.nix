{
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    gnupg = {
      home = "${config.home.homeDirectory}/.gnupg";
      sshKeyPaths = [];
    };

    defaultSopsFile = ./secrets/secrets.yaml;

    secrets = {
      "mopidy/spotify_client_id" = {};
      "mopidy/spotify_client_secret" = {};
    };
  };
}
