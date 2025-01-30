{config, ...}: {
  programs.matlab = {
    enable = true;
    installDir = "${config.home.homeDirectory}/Documents/MATLAB";
  };
}
