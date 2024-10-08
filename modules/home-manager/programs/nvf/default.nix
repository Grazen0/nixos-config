{inputs, ...}: {
  imports = [
    inputs.nvf.homeManagerModules.default
    ./lsp
    ./plugins
    ./debugger.nix
    ./keymaps.nix
    ./opts.nix
    ./visuals.nix
  ];

  programs.nvf = {
    enable = true;
    defaultEditor = true;

    settings.vim = {
      extraLuaFiles = [
        ./lua/autocmds.lua
        ./lua/user-commands.lua
      ];

      viAlias = true;
      vimAlias = true;

      withPython3 = true;
      withNodeJs = true;
    };
  };
}
