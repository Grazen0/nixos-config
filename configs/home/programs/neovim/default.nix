{
  pkgs,
  stablePkgs,
  inputs,
  ...
}:
{
  xdg.nixConfigFile.nvim.source = ./config;

  programs.neovim =
    let
      stablePlugins = stablePkgs.vimPlugins;
    in
    {
      package = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;

      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      plugins = with pkgs.vimPlugins; [
        lazy-nvim

        # Mini
        mini-ai
        mini-extra
        mini-icons
        mini-pairs
        mini-sessions

        # Editor
        blink-cmp
        guess-indent-nvim
        luasnip
        nvim-spectre
        nvim-surround
        nvim-ts-autotag
        oil-nvim
        snacks-nvim
        undotree
        vim-tmux-navigator

        # LSP
        conform-nvim
        nvim-jdtls
        nvim-lspconfig
        nvim-treesitter.withAllGrammars
        SchemaStore-nvim

        # Visual
        fidget-nvim
        gitsigns-nvim
        kanagawa-nvim
        stablePlugins.lualine-nvim
        vim-illuminate

        # Misc
        markdown-preview-nvim
        nvim-dbee
        todo-comments-nvim
        typst-preview-nvim
        vimtex
        which-key-nvim
      ];

      extraPackages = with pkgs; [
        # Essentials
        fd
        ripgrep
        wl-clipboard

        # Conform formatters
        nixfmt-rfc-style
        ormolu
        prettierd
        black
        isort
        rustfmt
        typstyle

        # LSP servers
        arduino-language-server
        pyright # Python
        bash-language-server
        clang-tools
        clang
        stdenv.cc.libc.dev
        llvmPackages.libcxx
        clippy
        cmake-language-server
        coursier
        gopls # Go
        jdt-language-server # Java
        # kotlin-language-server
        lua-language-server
        metals
        nil # Nix
        rust-analyzer
        sqls
        statix
        svelte-language-server
        tailwindcss-language-server
        terraform-lsp
        texlab # LaTeX
        tinymist
        typescript-language-server
        verible
        vscode-langservers-extracted # HTML, CSS, JSON
        yaml-language-server

        # Plugin-specifics
        texlive.combined.scheme-small # vimtex
      ];

    };
}
