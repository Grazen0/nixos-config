{
  pkgs,
  inputs,
  ...
}: {
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
      ormolu
      prettierd
      rustfmt
      sql-formatter
      stylua

      # LSP servers
      autotools-language-server # Makefile
      bash-language-server
      cmake-language-server
      clang-tools
      emmet-language-server
      haskell-language-server
      jdt-language-server # Java
      nil # Nix
      lua-language-server
      pyright # Python
      rust-analyzer
      svelte-language-server
      tailwindcss-language-server
      taplo # TOML
      texlab # LaTeX
      typescript-language-server
      vim-language-server
      vscode-langservers-extracted # HTML, CSS, JSON
      yaml-language-server
      zls # Zig
      zig

      # nvim-dap
      jq
      vscode-js-debug
      (inputs.haskell-debug-adapter.packages.${system}.default)

      # Plugin-specifics
      texlive.combined.scheme-small # vimtex
      lldb # rustaceanvim
      cmake # cmake-tools.nvim
    ];

    extraPython3Packages = ps:
      with ps; [
        debugpy # nvim-dap-python
      ];
  };
}
