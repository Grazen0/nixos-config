{pkgs, ...}: {
  home.packages = with pkgs; [equibop];

  xdg.configFile.equibop = {
    source = ./config;
    recursive = true;
  };
}
