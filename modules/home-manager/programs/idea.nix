{pkgs, ...}: {
  home.packages = with pkgs; [
    jetbrains.idea-ultimate
  ];

  home.file.".ideavimrc".text = ''
    " Plugins =======================
    set surround
    set multiple-cursors
    set commentary
    set highlightedyank
    set NERDTree

    " Settings ======================
    set relativenumber
    set incsearch
    set ignorecase
    set smartcase
    set hlsearch

    " Use system clipboard
    set clipboard+=unnamedplus

    " Mapings =======================
    let mapleader=" "

    " Clear search highlights with <Esc>
    nmap <Esc> :nohl<CR>

    " Better redo
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
}
