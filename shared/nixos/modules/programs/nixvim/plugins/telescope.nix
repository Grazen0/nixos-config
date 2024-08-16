{pkgs, ...}: {
  programs.nixvim = {
    plugins.telescope = {
      enable = true;

      keymaps = {
        "<leader>ff" = "find_files";
        "<leader>fg" = "live_grep";
        "<leader>fb" = "buffers";
        "<leader>fr" = "lsp_references";
        "<leader>fh" = "help_tags";
        "<leader>ft" = "todo-comments";
      };

      settings.defaults = {
        file_ignore_patterns = [
          "^.git/"
          "^.mypy_cache/"
          "^__pycache__/"
          "^output/"
          "^data/"

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
      };
    };

    extraPackages = with pkgs; [
      ripgrep
      fd
    ];
  };
}
