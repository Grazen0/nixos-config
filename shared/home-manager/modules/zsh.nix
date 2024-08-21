{
  config,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;

    shellAliases = let
      flakeDir = "${config.xdg.configHome}/nixos";
    in {
      h = "Hyprland";

      ls = "eza --group-directories-first";
      la = "ls -a";
      ll = "ls -l --icons";
      lla = "ll -a";
      lt = "ls --tree --icons";
      lta = "lt -a";
      l = "lla -h";
      lsfr = "${pkgs.coreutils}/bin/ls";

      grep = "grep --color=auto";
      fgrep = "fgrep --color=auto";
      egrep = "egrep --color=auto";

      g = "git";
      gs = "git status";
      ga = "git add";
      gb = "git branch";
      gbd = "git branch --delete";
      gaa = "git add --all";
      gcm = "git commit --message";
      gd = "git diff";
      gdw = "git diff --word-diff";
      gl = "git pull";
      gp = "git push";
      grm = "git rm";
      grmc = "git rm --cached";
      grh = "git reset";
      grhu = "git reset HEAD~"; # Undo last commit
      grs = "git restore";
      grst = "git restore --staged";

      cat = "bat";
      catfr = "${pkgs.coreutils}/bin/cat";

      rm = "rmtrash";
      rmdir = "rmdirtrash";
      rmfr = "${pkgs.coreutils}/bin/rm";
      rmdirfr = "${pkgs.coreutils}/bin/rmdir";

      v = "nvim";
      emacs = "nvim";

      ve = "python -m venv ./.venv";
      va = "source ./.venv/bin/activate";

      peaclock = "peaclock --config-dir ${config.xdg.configHome}/peaclock";

      "2048" = "2048-in-terminal";

      rb = "sudo nixos-rebuild --flake ${flakeDir}";
      rbs = "sudo nixos-rebuild switch --flake ${flakeDir}";
      rbb = "sudo nixos-rebuild boot --flake ${flakeDir}";
      rbt = "sudo nixos-rebuild test --flake ${flakeDir}";
      upd = "nix flake update ${flakeDir}";

      # I'm kinda clumsy
      ":q" = "exit";
      ":x" = "exit";
    };

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    plugins = [
      {
        name = "aphrodite";
        file = "aphrodite.zsh-theme";
        src = pkgs.fetchFromGitHub {
          owner = "win0err";
          repo = "aphrodite-terminal-theme";
          rev = "2c9e4c95ec34fbe32500f39c3f99cedb530a52f7";
          sha256 = "14zckxarajhqzcps7hq05gcmmqcy3c0f0xpfa2vadjb6hl66mvks";
        };
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
      export PATH="$PATH:$HOME/.local/bin"

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

      # Highlight colors for zsh-vi-mode
      export ZVM_VI_HIGHLIGHT_BACKGROUND="#223249"
      export ZVM_VI_HIGHLIGHT_FOREGROUND="#dcd7ba"

      # Options for zsh-history-substring-search
      export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="underline"
      export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND="default"
      export HISTORY_SUBSTRING_SEARCH_PREFIXED="yeah"
    '';
  };
}
