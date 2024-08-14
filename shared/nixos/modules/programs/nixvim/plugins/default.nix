{
  imports = [
    ./cmp.nix
    ./conform.nix
    ./extra.nix
    ./mini.nix
    ./multicursors.nix
    ./nvim-tree.nix
    ./telescope.nix
    ./vimtex.nix
  ];

  # Plugins that don't require config
  programs.nixvim.plugins = {
    comment.enable = true;
    inc-rename.enable = true;
    gitgutter.enable = true;
    markdown-preview.enable = true;
    neocord.enable = true;
    nvim-autopairs.enable = true;
    nvim-colorizer.enable = true;
    lualine.enable = true;
    surround.enable = true;
    todo-comments.enable = true;
  };
}
