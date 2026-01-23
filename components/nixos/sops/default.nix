{ inputs, ... }:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops = {
    defaultSopsFile = ./secrets/secrets.yaml;
    age.keyFile = "/var/lib/sops-nix/key.txt";

    secrets = {
      "cloudflared/tunnel_credentials" = { };
      "caddy/cloudflare_api_token" = { };
      "glance/immich_api_key" = { };
      "radicale/htpasswd" = {
        owner = "radicale";
      };
      "unilife/minio_env" = { };
      "unilife/db_env" = { };
      "unilife/backend_env" = { };
      "unilife/frontend_env" = { };
      "forgejo/token" = { };
    };
  };

}
