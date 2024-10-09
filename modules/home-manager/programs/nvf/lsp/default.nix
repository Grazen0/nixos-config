{pkgs, ...}: {
  imports = [
    ./treesitter.nix
    ./languages.nix
  ];

  programs.nvf.settings.vim = {
    languages.enableLSP = true;

    extraPackages = with pkgs; [
      emmet-language-server
      haskell-language-server
      texlab
      vscode-langservers-extracted
      yaml-language-server
    ];

    extraPlugins = with pkgs; {
      schemastore.package = vimPlugins.SchemaStore-nvim;
    };

    lsp = {
      enable = true;
      lspkind = {
        enable = true;
        mode = "symbol";
      };

      trouble.enable = true;

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

        emmet = ''
          lspconfig.emmet_language_server.setup({
            capabilities = capabilities,
            on_attach = default_on_attach,
          })
        '';
      };
    };
  };
}
