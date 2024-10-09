{
  programs.nvf.settings.vim = {
    leaderKey = " ";

    spellcheck.languages = ["en" "es"];

    options = {
      cursorline = true;
      linebreak = true;
    };

    cursorlineOpt = "both";
    undoFile.enable = true;
    searchCase = "smart";
    useSystemClipboard = true;
    scrollOffset = 4;
  };
}
