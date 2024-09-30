{pkgs, ...}: {
  programs.nvf.settings.vim.extraPlugins.gitsigns = {
    package = pkgs.vimPlugins.gitsigns-nvim;
    setup = ''
      require('gitsigns').setup({
        current_line_blame = true,
        current_line_blame_opts = {
          delay = 500,
        },
      })
    '';
  };
}
