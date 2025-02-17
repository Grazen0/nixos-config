{
  imports = [
    ./pipewire.nix
  ];

  services = {
    printing.enable = true;
    libinput.enable = true;
    gvfs.enable = true;
    tumbler.enable = true;

    openssh = {
      enable = false;
      ports = [22];
      openFirewall = true;

      settings = {
        PasswordAuthentication = true;
        AllowUsers = ["jdgt"];
        UseDns = true;
        X11Forwarding = false;
        PermitRootLogin = "prohibit-password";
      };
    };
  };
}
