{
  programs.jetbrains = {
    enable = true;

    editors = {
      idea-ultimate.enable = true;
      pycharm-professional.enable = true;
      datagrip.enable = true;
    };

    ideavimrc =
      # vim
      ''
        " Plugins =======================
        set surround
        set commentary
        set highlightedyank
        set NERDTree
        set argtextobj
        set textobj-indent
        set functiontextobj
        set peekaboo
        set which-key

        " Settings ======================
        set relativenumber
        set incsearch
        set ignorecase
        set smartcase
        set hlsearch

        " Mappings =======================
        let mapleader=" "
        let maplocalleader=","

        " Clear search highlights with <Esc>
        nmap <Esc> :nohl<CR>

        " Helix-like stuff
        nmap gh ^
        nmap gl $
        nmap U <C-r>

        " NERDTree
        nmap <leader>e :NERDTree<CR>

        " Editor stuff
        nmap <leader>r <Action>(Run)
        nmap <leader>d <Action>(ShowErrorDescription)
        nmap L <Action>(NextTab)
        nmap H <Action>(PreviousTab)

        " Gotos
        nmap gd <Action>(GotoDeclaration)
        nmap ge <Action>(GotoNextError)
        nmap gi <Action>(GotoImplementation)
        nmap gt <Action>(GotoTypeDeclaration)
        nmap gu <Action>(GotoDeclaration)
        nmap gz <Action>(GotoTest)

        nmap <C-h> <C-w>h
        nmap <C-j> <C-w>j
        nmap <C-k> <C-w>k
        nmap <C-l> <C-w>l
      '';
  };
}
