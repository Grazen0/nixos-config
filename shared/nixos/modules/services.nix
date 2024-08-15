{pkgs, ...}: {
  powerManagement.enable = true;

  services = {
    pipewire.enable = true;
    printing.enable = true;
    libinput.enable = true;
    blueman.enable = true;
    gvfs.enable = true;
    tumbler.enable = true;

    # Laptop
    thermald.enable = true;
    tlp.enable = true;

    # Hibernate on <5% battery
    udev.extraRules = ''
      SUBSYSTEM=="power_supply", ATTR{status}=="Discharging", ATTR{capacity}=="[0-5]", RUN+="${pkgs.systemd}/bin/systemctl hibernate"
    '';
  };
}
