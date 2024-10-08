{pkgs, ...}: {
  programs.nvf.settings.vim = {
    extraPackages = with pkgs; [
      haskell-language-server
      yaml-language-server
      vscode-langservers-extracted
    ];

    lsp = {
      enable = true;
      lspkind = {
        enable = true;
        mode = "symbol";
      };
      lspSignature.enable = true;
      formatOnSave = true;

      lspconfig.sources = let
        mkDefaultSetup = name: ''
          lspconfig['${name}'].setup({
            capabilities = capabilities,
            on_attach = default_on_attach,
          })
        '';
      in {
        texlab = mkDefaultSetup "texlab";
        hls = mkDefaultSetup "hls";
        json = ''
          lspconfig.jsonls.setup({
            capabilities = capabilities,
            on_attach = default_on_attach,
            settings = {
              json = {
                schemas = require('schemastore').json.schemas(),
                validate = { enable = true },
              },
            },
          })
        '';
        yaml = ''
          lspconfig.yamlls.setup({
            capabilities = capabilities,
            on_attach = default_on_attach,
            settings = {
              yaml = {
                schemaStore = {
                  enable = false,
                  url = ''',
                },
                schemas = require('schemastore').yaml.schemas(),
              },
            },
          })
        '';
      };
    };

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

    languages = {
      enableLSP = true;
      enableTreesitter = true;

      bash.enable = true;
      nix.enable = true;
      lua = {
        enable = true;
        lsp.neodev.enable = true;
      };
      markdown.enable = true;
      rust = {
        enable = true;
        crates.enable = true;
      };
      clang.enable = true;
      java.enable = true;
      python = {
        enable = true;
        format.type = "black-and-isort";
        lsp.server = "pyright";
      };
      ts.enable = true;
      html.enable = true;
      css.enable = true;
      svelte.enable = true;
      tailwind.enable = true;
    };

    extraPlugins = with pkgs; {
      schemastore.package = vimPlugins.SchemaStore-nvim;

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
