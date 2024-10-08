{
  programs.nvf.settings.vim.languages = {
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
}
