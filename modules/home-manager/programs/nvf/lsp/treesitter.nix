{
  lib,
  pkgs,
  ...
}: {
  programs.nvf.settings.vim = {
    languages.enableTreesitter = true;

    treesitter = let
      disabledGrammars = with pkgs.tree-sitter-grammars; [
        tree-sitter-latex
      ];
    in {
      fold = true;
      autotagHtml = true;
      highlight.disable = ["latex"];

      # All grammars except for disabledGrammars
      grammars = lib.attrValues (lib.filterAttrs (key: pkg: (lib.hasPrefix "tree-sitter-" key) && !(lib.elem pkg disabledGrammars)) pkgs.tree-sitter-grammars);
    };

    extraPlugins = with pkgs; {
      treesitter-latex-parser.package = vimPlugins.nvim-treesitter-parsers.latex;
    };
  };
}
