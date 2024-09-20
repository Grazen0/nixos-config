{
  programs.nixvim = {
    clipboard = {
      register = "unnamedplus";
      providers.wl-copy.enable = true;
    };

    opts = {
      encoding = "utf-8";
      compatible = false;
      hidden = true;
      updatetime = 100;

      signcolumn = "yes";
      fillchars = "eob: ";
      autoindent = true;
      expandtab = true;
      tabstop = 4;
      softtabstop = 4;
      shiftwidth = 4;
      linebreak = true;

      syntax = "on";
      ignorecase = true;
      hlsearch = true;
      incsearch = true;
      number = true;
      wildmode = "longest,list";
      mouse = "a";
      cursorline = true;
      ttyfast = true;
      termguicolors = true;

      spelllang = ["en_us" "es_es"];

      undofile = true;
    };
  };
}
