{
  imports = [
    ./openssh.nix
    ./pipewire.nix
  ];

  services = {
    printing.enable = true;
    libinput.enable = true;
    gvfs.enable = true;
    tumbler.enable = true;
  };
}
