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

    formatOnSave = {
      lspFallback = true;
      timeoutMs = 1000;
    };
  };

  programs.nixvim.extraPackages = with pkgs; [
    alejandra
    beautysh
    bibtex-tidy
    black
    isort
    prettierd
    rustfmt
    stylua
  ];
}
