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

      treesitter-textobjects = {
        package = vimPlugins.nvim-treesitter-textobjects;
        setup = ''
          require('nvim-treesitter.configs').setup({
            textobjects = {
              select = {
                enable = true,
                keymaps = {
                  ['aa'] = '@parameter.outer',
                  ['ia'] = '@parameter.inner',
                  ['af'] = '@function.outer',
                  ['if'] = '@function.inner',
                  ['ac'] = '@class.outer',
                  ['ic'] = '@class.inner',
                  ['ai'] = '@conditional.outer',
                  ['ii'] = '@conditional.inner',
                  ['al'] = '@loop.outer',
                  ['il'] = '@loop.inner',
                  ['ak'] = '@block.outer',
                  ['ik'] = '@block.inner',
                  ['is'] = '@statement.inner',
                  ['as'] = '@statement.outer',
                  ['ad'] = '@comment.outer',
                  ['am'] = '@call.outer',
                  ['im'] = '@call.inner',
                },
              },
            },
          })
        '';
      };
    };
  };
}
