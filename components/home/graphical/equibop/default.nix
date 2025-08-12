{ pkgs, ... }:
{
  home.packages = with pkgs; [ equibop ];

  xdg.nixConfigFile.equibop.source = ./config;
}
