{host, ...}: {
  networking = {
    hostName = host;
    networkmanager.enable = true;
  };
}
