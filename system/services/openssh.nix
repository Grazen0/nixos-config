{
  services.openssh = {
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
}
