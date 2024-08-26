{pkgs, ...}: {
  powerManagement.enable = true;

  services = {
    thermald.enable = true;
    tlp.enable = true;

    # Hibernate on <5% battery
    # FIXME: doesn't actually work
    udev.extraRules = ''
      SUBSYSTEM=="power_supply", ATTR{status}=="Discharging", ATTR{capacity}=="[0-5]", RUN+="${pkgs.systemd}/bin/systemctl hibernate"
    '';
  };
}
