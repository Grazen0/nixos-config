{pkgs, ...}: {
  home.packages = with pkgs; [equibop];

  # TODO: maybe set settings.json from here to avoid hardcoding splash gif path
  xdg.configFile.equibop = {
    source = ./config;
    recursive = true;
  };
}
