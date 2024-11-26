{lib, ...}: {
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
      ${lib.readFile ./lua/init.lua}
      ${lib.readFile ./lua/opts.lua}
      ${lib.readFile ./lua/maps.lua}
      ${lib.readFile ./lua/autocmds.lua}
      ${lib.readFile ./lua/user-commands.lua}
      ${lib.readFile ./lua/lsp.lua}
    '';
  };
}
