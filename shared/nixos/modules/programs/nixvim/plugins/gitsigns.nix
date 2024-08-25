{
  programs.nixvim.plugins.gitsigns = {
    enable = true;

    settings = {
      current_line_blame = true;
      current_line_blame_opts.delay = 500;
    };
  };
}
