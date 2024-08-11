{
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;

      # folding = true;

      settings = {
        indent.enable = true;
        highlight = {
          enable = true;
          disable = ["latex"];
        };
        autotag = {
          enable = true;
          enable_close_on_slash = false;
        };
      };
    };

    treesitter-refactor = {
      enable = true;

      highlightDefinitions = {
        enable = true;
        clearOnCursorMove = false;
      };

      navigation = {
        enable = true;

        keymaps = {
          gotoDefinitionLspFallback = "gd";
          listDefinitions = "gD";
          listDefinitionsToc = "gO";
          gotoNextUsage = "<A-*>";
          gotoPreviousUsage = "<A-#>";
        };
      };
    };
  };
}
