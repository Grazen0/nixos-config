{ pkgs, ... }:
{
  programs.thunar = {
    plugins = with pkgs; [
      thunar-archive-plugin
      thunar-volman
    ];
  };
}
