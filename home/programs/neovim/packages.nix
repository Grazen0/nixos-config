{
  pkgs,
  customPkgs,
  ...
}: {
  # Needed for obsidian.nvim, dang it
  home.packages = with pkgs; [wl-clipboard];

  programs.neovim = {
    extraPackages = with pkgs; [
      # Essentials
      fd
      ripgrep
      wl-clipboard

      # Conform formatters
      alejandra
      beautysh
      black
      clang-tools
      isort
      (mdformat.withPlugins (_ps: [
        customPkgs.mdformat-obsidian
      ]))
      prettierd
      rustfmt
      stylua

      # LSP servers
      autotools-language-server # Makefile
      bash-language-server
      cmake-language-server
      clang-tools
      emmet-language-server
      haskell-language-server
      jdt-language-server # Java
      nixd # Nix
      lua-language-server
      pyright # Python
      rust-analyzer
      svelte-language-server
      tailwindcss-language-server
      taplo # TOML
      texlab # LaTeX
      nodePackages.typescript # For tsserver
      vim-language-server
      vscode-langservers-extracted # HTML, CSS, JSON
      yaml-language-server
      zls # Zig
      zig

      # nvim-dap adapter stuff
      vscode-js-debug

      # Plugin-specifics
      texlive.combined.scheme-full # vimtex
      lldb # rustaceanvim
      cmake # cmake-tools.nvim
    ];
  };
}
