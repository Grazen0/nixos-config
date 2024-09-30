{pkgs, ...}: {
  programs.nvf.settings.vim = {
    lsp = {
      enable = true;
      lspkind.enable = true;
      lspSignature.enable = true;
      formatOnSave = true;

      lspconfig.sources.texlab = ''
        lspconfig.texlab.setup({
          capabilities = capabilities,
          on_attach = default_on_attach,
          cmd = { '${pkgs.texlab}/bin/texlab' },
        })
      '';
    };

    treesitter = {
      enable = true;
      fold = true;
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
      python.enable = true;
      ts.enable = true;
      html.enable = true;
      css.enable = true;
      svelte.enable = true;
      tailwind.enable = true;
    };
  };
}
