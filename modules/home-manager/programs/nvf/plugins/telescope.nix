{
  lib,
  pkgs,
  ...
}: {
  programs.nvf.settings.vim = {
    extraPackages = with pkgs; [ripgrep fd];

    telescope = let
      inherit (lib.generators) mkLuaInline;
    in {
      enable = true;

      mappings = {
        open = null;
        resume = null;
        lspDefinitions = "<leader>fd";
        lspImplementations = "<leader>fi";
        lspReferences = "<leader>fr";
      };

      setupOpts = {
        defaults = {
          layout_config.horizontal.prompt_position = "bottom";
          sorting_strategy = "descending";

          file_ignore_patterns = [
            "^.git/"
            "^.mypy_cache/"
            "^__pycache__/"
            "^output/"
            "^data/"
            "dist/"
            "build/"
            "target/"
            "result/"

            "%.o"
            "%.a"
            "%.out"
            "%.ipynb"
            "%.class"
            "%.pdf"
            "%.mkv"
            "%.mp4"
            "%.png"
            "%.jpg"
            "%.jpeg"
            "%.webp"
            "%.gif"
          ];

          mappings.n."<S-d>" = mkLuaInline "require('telescope.actions').delete_buffer";
        };
      };
    };
  };
}
