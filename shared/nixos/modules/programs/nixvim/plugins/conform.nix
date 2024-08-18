{pkgs, ...}: {
  programs.nixvim.plugins.conform-nvim = {
    enable = true;

    formattersByFt = {
      html = ["prettierd"];
      javascriptreact = ["prettierd"];
      typescriptreact = ["prettierd"];
      javascript = ["prettierd"];
      typescript = ["prettierd"];
      graphql = ["prettierd"];
      json = ["prettierd"];
      css = ["prettierd"];
      python = ["isort" "black"];
      lua = ["stylua"];
      rust = ["rustfmt"];
      tex = ["bibtex-tidy"];
      plaintex = ["bibtex-tidy"];
      c = ["clang-format"];
      cpp = ["clang-format"];
      yaml = ["prettierd"];
      sh = ["beautysh"];
      bash = ["beautysh"];
      zsh = ["beautysh"];
      nix = ["alejandra"];
    };

    formatOnSave = ''
      function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return;
        end
        return { timeout_ms = 1000, lsp_format = "fallback" };
      end
    '';
  };

  programs.nixvim.extraPackages = with pkgs; [
    alejandra
    beautysh
    bibtex-tidy
    black
    isort
    prettierd
    stylua
  ];
}
