{
  services = {
    pipewire.enable = true;
    thermald.enable = true;
    printing.enable = true;
    libinput.enable = true;
    blueman.enable = true;
    gvfs.enable = true;
    tumbler.enable = true;

    upower = {
      enable = true;
      percentageCritical = 5;
      criticalPowerAction = "Hibernate";
    };
  };
}
