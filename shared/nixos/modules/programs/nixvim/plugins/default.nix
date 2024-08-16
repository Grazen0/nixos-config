{
  imports = [
    ./cmp.nix
    ./conform.nix
    ./mini.nix
    ./multicursors.nix
    ./nvim-tree.nix
    ./telescope.nix
    ./ultisnips.nix
    ./vimtex.nix
  ];

  # Plugins that don't require config
  programs.nixvim.plugins = {
    comment.enable = true;
    inc-rename.enable = true;
    indent-blankline.enable = true;
    gitsigns.enable = true;
    markdown-preview.enable = true;
    neocord.enable = true;
    nvim-autopairs.enable = true;
    nvim-colorizer.enable = true;
    lualine.enable = true;
    todo-comments.enable = true;
    surround.enable = true;
  };
}
