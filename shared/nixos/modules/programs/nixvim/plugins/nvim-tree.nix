{
  programs.nixvim.plugins.nvim-tree = {
    enable = true;

    hijackCursor = true;
    view.relativenumber = true;

    diagnostics = {
      enable = true;
      showOnDirs = true;
      showOnOpenDirs = false;
    };

    renderer = {
      highlightGit = true;
      icons.show = {
        folderArrow = false;
        git = false;
      };
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
