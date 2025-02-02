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

      # Plugin-specifics
      # xxd # hex-nvim
      texlive.combined.scheme-full # vimtex
      imagemagick # image.nvim
      quarto # r.nvim
    ];

    extraLuaPackages = ps:
      with ps; [
        magick # image.nvim
      ];

    extraPython3Packages = ps:
      with ps; [
        pynvim
        pyperclip
        jupyter-client
        ipykernel
      ];
  };
}
