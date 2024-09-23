{
  services = {
    pipewire = {
      enable = true;
      alsa.enable = false;
      pulse.enable = false;
    };
    printing.enable = false;
    libinput.enable = true;
    blueman.enable = true;
    gvfs.enable = true;
    tumbler.enable = true;
  };
}
