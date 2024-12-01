{
  config,
  pkgs,
  inputs,
  ...
}: {
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    shellAliases = let
      flakeDir = "${config.xdg.configHome}/nixos";
    in {
      ls = "eza --group-directories-first";
      la = "ls -a";
      ll = "ls -l --icons=auto";
      lla = "ll -a";
      lt = "ls --tree --icons=auto";
      lta = "lt -a";
      l = "lla -h";
      lsfr = "${pkgs.coreutils}/bin/ls";

      "md" = "mkdir -p";
      "rd" = "rmdir";
      "rdfr" = "rmdirfr";
      "~" = "cd";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";
      "/" = "cd /";

      grep = "grep --color=auto";
      fgrep = "fgrep --color=auto";
      egrep = "egrep --color=auto";

      g = "git";
      ga = "git add";
      gaa = "git add --all";
      gb = "git branch";
      gbd = "git branch --delete";
      gco = "git checkout";
      gcb = "git checkout -b";
      gcB = "git checkout -B";
      gcm = "git checkout main";
      gcl = "git clone --recurse-submodules";
      gcmsg = "git commit --message";
      gc = "git commit --verbose";
      gd = "git diff";
      gdca = "git diff --cached";
      gdcw = "git diff --cached --word-diff";
      gds = "git diff --staged";
      gdw = "git diff --word-diff";
      ghh = "git help";
      gl = "git pull";
      gp = "git push";
      gpsup = "git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)";
      grh = "git reset";
      grhu = "git reset HEAD~"; # Undo last commit
      grm = "git rm";
      grmc = "git rm --cached";
      grs = "git restore";
      grst = "git restore --staged";
      grv = "git revert";
      gstaa = "git stash apply";
      gstc = "git stash clear";
      gstd = "git stash drop";
      gstl = "git stash list";
      gstp = "git stash pop";
      gsta = "git stash push";
      gst = "git status";
      gss = "git status --short";

      cat = "bat";
      catfr = "${pkgs.coreutils}/bin/cat";

      rm = "rmtrash";
      rmdir = "rmdirtrash";
      rmfr = "${pkgs.coreutils}/bin/rm";
      rmdirfr = "${pkgs.coreutils}/bin/rmdir";

      v = "nvim";
      emacs = "nvim";

      peaclock = "peaclock --config-dir ${config.xdg.configHome}/peaclock";
      lg = "lazygit";

      rbs = "sudo nixos-rebuild switch --flake ${flakeDir}";
      rbb = "sudo nixos-rebuild boot --flake ${flakeDir}";
      rbt = "sudo nixos-rebuild test --flake ${flakeDir}";
      hms = "home-manager switch --flake ${flakeDir}";
      hmn = "home-manager news --flake ${flakeDir}";
      upd = "nix flake update --flake ${flakeDir}";
      nsh = "nix shell";

      # I'm kinda clumsy
      ":q" = "exit";
      ":x" = "exit";
    };

    plugins = [
      {
        name = "aphrodite";
        src = inputs.aphrodite-terminal-theme;
        file = "aphrodite.zsh-theme";
      }
      {
        name = "autopair";
        src = pkgs.zsh-autopair;
        file = "share/zsh/zsh-autopair/autopair.zsh";
      }
      {
        name = "vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
    ];

    completionInit = ''
      zmodload zsh/complist

      autoload -U compinit && compinit
      _comp_options+=(globdots)

      setopt AUTO_LIST
      setopt COMPLETE_IN_WORD

      zstyle ':completion:*' matcher-list ''' 'm:{a-zA-Z}={A-Za-z}' # Case-insensitive matching
      zstyle ':completion:*' completer _extensions _complete
      zstyle ':completion:*' menu select

      # Select previous completion menu item with Shift+Tab
      bindkey -M menuselect '^[[Z' reverse-menu-complete
    '';

    initExtra = ''
      # Accept autosuggestions with Ctrl+Space
      bindkey '^ ' autosuggest-accept

      # Extra bindings for history-substring-search
      bindkey '^[OA' history-substring-search-up
      bindkey '^[OB' history-substring-search-down
      bindkey -M vicmd 'k' history-substring-search-up
      bindkey -M vicmd 'j' history-substring-search-down

      # Better word deletion
      autoload -U select-word-style
      select-word-style bash

      # Ctrl+V to edit command in editor
      autoload -Uz edit-command-line
      zle -N edit-command-line
      bindkey -M viins '^v' edit-command-line
      bindkey -M vicmd '^v' edit-command-line
    '';

    sessionVariables =
      {
        # Show the time in prompt
        APHRODITE_THEME_SHOW_TIME = "yes";

        # Options for zsh-history-substring-search
        HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND = "underline";
        HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND = "default";
        HISTORY_SUBSTRING_SEARCH_PREFIXED = "yeah";
      }
      // (let
        colors = config.theme.colors.hexWithHashtag;
      in {
        # Highlight colors for zsh-vi-mode
        ZVM_VI_HIGHLIGHT_BACKGROUND = colors.highlight;
        ZVM_VI_HIGHLIGHT_FOREGROUND = colors.brightWhite;
      });
  };
}
