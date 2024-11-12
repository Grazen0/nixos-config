{
  imports = [
    ./plugins.nix
    ./packages.nix
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;

    withNodeJs = true;
    withPython3 = true;
    withRuby = true;

    extraLuaConfig = ''
      ${builtins.readFile ./lua/init.lua}
      ${builtins.readFile ./lua/opts.lua}
      ${builtins.readFile ./lua/maps.lua}
      ${builtins.readFile ./lua/autocmds.lua}
      ${builtins.readFile ./lua/user-commands.lua}
      ${builtins.readFile ./lua/lsp.lua}
    '';
  };
}
