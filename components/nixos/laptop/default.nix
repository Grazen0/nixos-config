{
  powerManagement.enable = true;

  networking.networkmanager.wifi.powersave = true;

  services = {
    thermald.enable = true;
    auto-cpufreq.enable = true;
  };
}
