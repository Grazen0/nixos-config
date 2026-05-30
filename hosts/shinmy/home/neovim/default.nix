{
  lib,
  pkgs,
  ...
}:
{
  programs.neovim = {
    enable = true;

    defaultEditor = true;
    vimAlias = true;
    viAlias = true;

    initLua = lib.readFile ./init.lua;

    withPython3 = true;
    withNodeJs = true;
    withRuby = false;

    sideloadInitLua = true;

    extraPackages = with pkgs; [
      fd
      gcc
      ripgrep
      tree-sitter

      lua-language-server
      nil
      typescript-language-server
    ];
  };
}
