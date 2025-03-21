{
  services.openssh = {
    ports = [22];
    openFirewall = true;

    settings = {
      PasswordAuthentication = true;
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "prohibit-password";
    };
  };
}
