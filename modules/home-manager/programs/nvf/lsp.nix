{pkgs, ...}: {
  programs.nvf.settings.vim = {
    extraPackages = with pkgs; [
      haskell-language-server
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
          lspconfig.${name}.setup({
            capabilities = capabilities,
            on_attach = default_on_attach,
          })
        '';
      in {
        texlab = mkDefaultSetup "texlab";
        hls = mkDefaultSetup "hls";
      };
    };

    treesitter = {
      enable = true;
      fold = true;
      autotagHtml = true;
      indent.enable = true;
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

    extraPlugins.treesitter-refactor = {
      package = pkgs.vimPlugins.nvim-treesitter-refactor;
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
}
