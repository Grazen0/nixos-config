{
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
  ];

  networking = {
    wireless.enable = false; # wpa_supplicant bad
    networkmanager.enable = true; # nm good
  };

  programs = {
    neovim = {
      enable = true;

      configure.customRC =
        # vim
        ''
          set encoding=utf-8
          set nocompatible

          set number
          set relativenumber
          set signcolumn=yes
          set scrolloff=1
          set cursorline
          set cursorlineopt=both

          set breakindent
          set linebreak

          set ignorecase
          set smartcase
          set hlsearch

          set shiftwidth=4
          set tabstop=4
          set expandtab

          set autoread
          set mouse=a
          set splitright
          set undofile
          set updatetime=300

          nnoremap <Esc> <cmd>nohl<CR>

          nnoremap <C-h> <C-w>h
          nnoremap <C-j> <C-w>j
          nnoremap <C-k> <C-w>k
          nnoremap <C-l> <C-w>l

          nnoremap <A-h> <C-w>H
          nnoremap <A-j> <C-w>J
          nnoremap <A-k> <C-w>K
          nnoremap <A-l> <C-w>L

          nnoremap <A-,> <C-w><lt>
          nnoremap <A-.> <C-w>>
          nnoremap <A--> <C-w>-
          nnoremap <A-=> <C-w>+

          nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
          nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

          autocmd BufReadPost * silent! normal g`"zv
          autocmd TextYankPost * lua vim.highlight.on_yank({ higroup = 'Search', timeout = 500 })
          autocmd FileType help wincmd L
        '';

      defaultEditor = true;
    };

    tmux = {
      enable = true;

      plugins = with pkgs.tmuxPlugins; [
        sensible
        yank
      ];

      escapeTime = 0;
      shortcut = "a";
      baseIndex = 1;

      extraConfig =
        # tmux
        ''
          # Pane navigation with hjkl
          bind h select-pane -L
          bind j select-pane -D
          bind k select-pane -U
          bind l select-pane -R

          # Resize panes with hjkl
          bind -r C-h resize-pane -L
          bind -r C-j resize-pane -D
          bind -r C-k resize-pane -U
          bind -r C-l resize-pane -R

          # Open panes in current directory
          bind % split-window -h -c "#{pane_current_path}"
          bind '"' split-window -v -c "#{pane_current_path}"

          # Also better split commands
          bind | split-window -h -c "#{pane_current_path}"
          bind - split-window -v -c "#{pane_current_path}"

          # Vim-style copy
          set-window-option -g mode-keys vi
          bind-key -T copy-mode-vi v send-keys -X begin-selection
          bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
          bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
        '';
    };
  };

  services.xserver.xkb.options = "caps:swapescape";
  console.useXkbConfig = true;
}
