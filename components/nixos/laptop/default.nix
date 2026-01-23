{
  powerManagement.enable = true;
  powerManagement.cpuFreqGovernor = "ondemand";

  networking.networkmanager.wifi.powersave = true;

  services = {
    thermald.enable = true;
    tlp.enable = true;
    auto-cpufreq.enable = true;
    upower.enable = true;
  };
}
