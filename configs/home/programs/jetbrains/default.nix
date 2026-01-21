{
  programs.jetbrains = {
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

        " Clear search highlights with <esc>
        nmap <esc> :nohl<cr>

        " Helix-like stuff
        nmap gh ^
        nmap gl $
        nmap U <c-r>

        " NERDTree
        nmap <leader>e :NERDTree<cr>

        " Editor stuff
        nmap <leader>r <action>(Run)
        nmap <leader>d <action>(ShowErrorDescription)
        nmap L <action>(NextTab)
        nmap H <action>(PreviousTab)

        " Gotos
        nmap gd <action>(GotoDeclaration)
        nmap ge <action>(GotoNextError)
        nmap gi <action>(GotoImplementation)
        nmap gt <action>(GotoTypeDeclaration)
        nmap gu <action>(GotoDeclaration)
        nmap gz <action>(GotoTest)

        nmap <c-h> <c-w>h
        nmap <c-j> <c-w>j
        nmap <c-k> <c-w>k
        nmap <c-l> <c-w>l
      '';
  };
}
