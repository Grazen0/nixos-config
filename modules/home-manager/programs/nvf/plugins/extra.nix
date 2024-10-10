{pkgs, ...}: {
  programs.nvf.settings.vim = {
    autopairs.enable = true;
    comments.comment-nvim.enable = true;
    utility = {
      surround.enable = true;
      diffview-nvim.enable = true;
    };

    autocomplete = {
      enable = true;
      type = "nvim-cmp";
      mappings.scrollDocsUp = "<C-b>";
    };

    notes.todo-comments = {
      enable = true;
      mappings.telescope = "<leader>ft";
    };

    presence.neocord.enable = true;

    extraPlugins = with pkgs; let
      withSetup = package: name: {
        inherit package;
        setup = "require('${name}').setup({})";
      };
    in {
      spectre.package = vimPlugins.nvim-spectre;
      inc-rename = withSetup vimPlugins.inc-rename-nvim "inc_rename";
      markview = withSetup vimPlugins.markview-nvim "markview";
      tailwindcss-colors = withSetup vimPlugins.tailwindcss-colors-nvim "tailwindcss-colors";
      markdown-preview.package = vimPlugins.markdown-preview-nvim;
      hex = withSetup vimPlugins.hex-nvim "hex";
    };

    globals.mkdp_filetypes = ["markdown"];

    extraPackages = with pkgs; [
      xxd
    ];
  };
}
