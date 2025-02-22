{pkgs, ...}: {
  home.packages = with pkgs; [equibop];

  xdg.configNixFile.equibop = {
    source = ./config;
  };
}
