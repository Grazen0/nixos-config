{
  imports = [
    ./lspkind.nix
    ./treesitter.nix
  ];

  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;

        servers = {
          nil-ls.enable = true; # Nix
          lua-ls.enable = true; # Lua
          hls.enable = true; # Haskell
          pyright.enable = true; # Python

          ts-ls.enable = true; # TypeScript/JavaScript
          html.enable = true; # HTML
          emmet-ls.enable = true; # HTML emmet snippets
          cssls.enable = true; # CSS
          jsonls.enable = true; # JSON
          yamlls.enable = true; # YAML
          tailwindcss.enable = true; # TailwindCSS
          svelte.enable = true; # Svelte

          clangd.enable = true; # C/C++
          cmake.enable = true; # GNU Make

          # Rust
          rust-analyzer = {
            enable = true;
            installRustc = true;
            installCargo = true;
          };

          texlab.enable = true; # LaTeX
        };
      };

      hmts.enable = true; # Causes crash on peaclock.nix
      schemastore.enable = true;
    };

    diagnostics.virtual_text = false;
  };
}