{
  lib,
  pkgs,
  inputs,
  ...
}:
{
  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;

    defaultEditor = true;
    vimAlias = true;
    viAlias = true;

    initLua = lib.readFile ./init.lua;

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
