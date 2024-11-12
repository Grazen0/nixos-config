{pkgs, ...}: {
  programs.neovim.extraPackages = with pkgs; [
    # Essentials
    fd
    ripgrep
    wl-clipboard

    # Conform formatters
    alejandra
    beautysh
    bibtex-tidy
    black
    clang-tools
    isort
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
    jdt-language-server
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

    xxd # hex-nvim
    texlive.combined.scheme-medium # vimtex
  ];
}
