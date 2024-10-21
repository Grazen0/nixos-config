{pkgs, ...}: {
  programs.nvf.settings.vim = {
    extraPackages = with pkgs; [texlive.combined.scheme-medium];

    globals = {
      vimtex_view_method = "zathura";
      vimtex_compiler_latexmk.out_dir = "dist";
    };

    extraPlugins.vimtex.package = pkgs.vimPlugins.vimtex;
  };
}
