{ pkgs, ... }:
{
  home.packages = with pkgs; [ vesktop ];

  xdg.nixConfigFile.vesktop.source = ./config;
}
