{pkgs, ...}: {
  programs.nvf.settings.vim = {
    languages.enableTreesitter = true;

    treesitter = {
      enable = true;
      fold = true;
      autotagHtml = true;
      indent.enable = true;

      grammars = with pkgs.tree-sitter-grammars; [
        tree-sitter-haskell
      ];

      highlight.disable = ["latex"];
    };

    extraPlugins = with pkgs; {
      treesitter-latex-parser.package = vimPlugins.nvim-treesitter-parsers.latex;

      treesitter-refactor = {
        package = vimPlugins.nvim-treesitter-refactor;
        setup = ''
          require('nvim-treesitter.configs').setup({
            refactor = {
              navigation = {
                enable = true,
                keymaps = {
                  goto_definition_lsp_fallback = "gd";
                  list_definitions = "gD";
                  list_definitions_toc = "gO";
                  goto_next_usage = "<A-*>";
                  goto_previous_usage = "<A-#>";
                },
              },
            },
          })
        '';
      };
    };
  };
}
