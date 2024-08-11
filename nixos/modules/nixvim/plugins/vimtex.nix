{
  programs.nixvim.plugins.vimtex = {
    enable = true;

    settings = {
      view_method = "zathura";
      compiler_latexmk = {
        out_dir = "dist";
      };
    };
  };
}
