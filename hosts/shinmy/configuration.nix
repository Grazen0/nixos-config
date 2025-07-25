{
  imports = [
    ./hardware-configuration.nix
  ];

  programs.neovim.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      KbdInteractiveAuthentication = true;
      PermitRootLogin = "no";
      AllowUsers = [ "jdgt" ];
    };
  };

  networking.hostName = "shinmy";
  system.stateVersion = "24.05";
}
