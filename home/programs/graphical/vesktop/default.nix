{pkgs, ...}: {
  home.packages = with pkgs; [vesktop];

  xdg.configFile.vesktop = {
    source = ./config;
    recursive = true;
  };
}
