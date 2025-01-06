{
  services = {
    pipewire = {
      enable = true;
      alsa.enable = false;
      pulse.enable = false;
    };
    printing.enable = true;
    libinput.enable = true;
    gvfs.enable = true;
    tumbler.enable = true;

    pulseaudio = {
      enable = true;
      support32Bit = true;
    };
  };
}
