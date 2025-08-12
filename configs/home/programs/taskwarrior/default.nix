{ pkgs, ... }:
{
  programs.taskwarrior = {
    package = pkgs.taskwarrior3;
  };
}
