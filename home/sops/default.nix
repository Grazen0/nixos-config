{
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    gnupg.home = "${config.home.homeDirectory}/.gnupg";
    defaultSopsFile = ./secrets/secrets.yaml;
    secrets."mopidy_spotify/client_id" = {};
    secrets."mopidy_spotify/client_secret" = {};
  };
}
