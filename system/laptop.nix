{
  powerManagement.enable = true;

  services = {
    thermald.enable = true;
    auto-cpufreq.enable = true;

    lowbatt = {
      enable = true;
      action = "hibernate";
      notifications.suspend.body = ''
        Computer will hibernate in 60 seconds.
        You should plug in your charger, NOW!!!
      '';
    };
  };
}
