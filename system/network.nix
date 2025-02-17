{
  networking = {
    networkmanager = {
      enable = true;
      wifi.powersave = true;
    };

    firewall.enable = true;
    nftables.enable = true;
  };
}
