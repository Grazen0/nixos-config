{
  config,
  pkgs,
  inputs,
  ...
}: {
  programs.neovim = {
    extraPackages = with pkgs; let
      inherit (pkgs.rPackages) buildRPackage;

      grkstyle = buildRPackage {
        name = "grkstyle";
        src = inputs.grkstyle;
        propagatedBuildInputs = with pkgs.rPackages; [
          magrittr
          purrr
          rlang
          rprojroot
          styler
        ];
      };

      r-nvim = buildRPackage {
        name = "r-nvim";
        src = inputs.r-nvim;
        propagatedBuildInputs = with pkgs.rPackages; [
          styler
          grkstyle
        ];
      };

      rWrapped = pkgs.rWrapper.override {
        packages =
          config.programs.r.rPackages
          ++ (with pkgs.rPackages; [
            quarto
            r-nvim
          ]);
      };
    in [
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

      # Misc
      xxd # hex-nvim
      texlive.combined.scheme-full # vimtex
      imagemagick # image.nvim
      rWrapped # r.nvim
    ];

    extraLuaPackages = ps:
      with ps; [
        magick # image.nvim
      ];
  };
}
