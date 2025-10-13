{ config, pkgs, ... }:
{

  virtualisation.oci-containers.containers = {
    unilife-db = {
      image = "postgres:17";
      environmentFiles = [
        config.sops.secrets."unilife/db_env".path
      ];
      ports = [ "5555:5432" ];
      volumes = [
        "/var/lib/unilife/db-data:/var/lib/postgresql/data"
      ];
      extraOptions = [
        "--network-alias=db"
        "--network=unilife-network"
      ];
    };

    unilife-minio = {
      image = "minio/minio";
      cmd = [
        "server"
        "/data"
        "--console-address"
        ":9001"
      ];
      environmentFiles = [
        config.sops.secrets."unilife/minio_env".path
      ];
      ports = [
        "9000:9000"
        "9001:9001"
      ];
      volumes = [
        "/var/lib/unilife/minio-data:/data"
      ];
      extraOptions = [
        "--network-alias=minio"
        "--network=unilife-network"
      ];
    };

    unilife-backend = {
      image = "grazen/unilife";
      ports = [ "8008:8080" ];
      environmentFiles = [
        config.sops.secrets."unilife/backend_env".path
      ];
      dependsOn = [
        "unilife-db"
        "unilife-minio"
      ];
      extraOptions = [
        "--network-alias=backend"
        "--network=unilife-network"
      ];
    };

    unilife-frontend = {
      image = "grazen/unilife-web";
      ports = [ "3300:3000" ];
      environmentFiles = [
        config.sops.secrets."unilife/frontend_env".path
      ];
      extraOptions = [
        "--network-alias=frontend"
        "--network=unilife-network"
      ];
      dependsOn = [ "unilife-backend" ];
    };
  };

  systemd.services."podman-volumes-unilife-minio" = {
    wantedBy = [ "multi-user.target" ];
    before = [
      "podman-unilife-minio.service"
    ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };

    script = ''
      mkdir -p /var/lib/unilife/minio-data
    '';
  };

  systemd.services."podman-volumes-unilife-db" = {
    wantedBy = [ "multi-user.target" ];
    before = [
      "podman-unilife-db.service"
    ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };

    script = ''
      mkdir -p /var/lib/unilife/db-data
    '';
  };

  systemd.services."podman-network-unilife" = {
    path = [ pkgs.podman ];
    wantedBy = [ "multi-user.target" ];
    before = [
      "podman-unilife-db.service"
      "podman-unilife-minio.service"
      "podman-unilife-backend.service"
      "podman-unilife-frontend.service"
    ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStop = "podman network rm -f unilife-network";
    };

    script = ''
      podman network inspect unilife-network || podman network create unilife-network
    '';
  };
}
