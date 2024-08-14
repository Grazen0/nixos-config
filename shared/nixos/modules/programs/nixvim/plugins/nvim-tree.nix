{
  programs.nixvim.plugins.nvim-tree = {
    enable = true;

    hijackCursor = true;
    view.relativenumber = true;

    renderer = {
      highlightGit.__raw = "'name'";
      icons.show.folderArrow = false;
    };

    filters.custom = ["^.git$"];
    git.ignore = false;

    trash.cmd = "gio trash";

    updateFocusedFile = {
      enable = true;
      updateRoot = true;
    };

    preferStartupRoot = true;
  };
}
