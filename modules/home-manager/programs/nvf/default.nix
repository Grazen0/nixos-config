{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nvf.homeManagerModules.default
    ./plugins
    ./keymaps.nix
    ./lsp.nix
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

      autopairs.enable = true;

      notes.todo-comments = {
        enable = true;
        mappings.telescope = "<leader>ft";
      };

      autocomplete = {
        enable = true;
        mappings.scrollDocsUp = "<C-b>";
      };

      git.enable = true;
      utility.surround.enable = true;
      comments.comment-nvim.enable = true;
      presence.neocord.enable = true;

      extraPlugins = with pkgs; let
        withSetup = package: name: {
          inherit package;
          setup = "require('${name}').setup({})";
        };
      in {
        spectre.package = vimPlugins.nvim-spectre;
        inc-rename = withSetup vimPlugins.inc-rename-nvim "inc_rename";
        nvim-window-picker = withSetup vimPlugins.nvim-window-picker "window-picker";
        multicursors = withSetup vimPlugins.multicursors-nvim "multicursors";
      };
    };
  };
}
