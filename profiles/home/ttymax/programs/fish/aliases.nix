{
  config,
  pkgs,
  customPkgs,
  ...
}:
{
  programs.fish.shellAliases =
    let
      flakeDir = "${config.xdg.configHome}/nixos";
      yt-dlp = "${pkgs.yt-dlp}/bin/yt-dlp";
      tmux-music = "${customPkgs.tmux-music}/bin/tmux-music";
    in
    {
      # Required so that sudo can use aliases
      sudo = "sudo ";

      ls = "eza --group-directories-first";
      la = "ls -a";
      ll = "ls -l --icons=auto";
      lla = "ll -a";
      lt = "ls --tree --icons=auto";
      lta = "lt -a";
      l = "lla -h";
      lsfr = "${pkgs.coreutils}/bin/ls";

      mkdir = "mkdir -p";
      ".." = "cd ..";
      "..." = "cd ../..";

      df = "df -h";
      grep = "grep --color=auto";
      ta = "tmux attach";
      lg = "lazygit";
      music = "${tmux-music} ${./default_album_art.png}";

      cat = "bat";
      catfr = "${pkgs.coreutils}/bin/cat";

      rm = "rmtrash";
      rmdir = "rmdirtrash";
      rmfr = "${pkgs.coreutils}/bin/rm";
      rmdirfr = "${pkgs.coreutils}/bin/rmdir";
      restore = "trash-restore";

      v = "nvim";
      vs = "nvim -S";
      emacs = "nvim";
      emacss = "vs";

      peaclock = "peaclock --config-dir ${config.xdg.configHome}/peaclock";
      # "Borrowed" from https://github.com/NotAShelf/nyx/blob/main/homes/notashelf/programs/terminal/shell/zsh/aliases.nix#L39

      ytmp3 = ''${yt-dlp} -x -c --add-metadata --embed-thumbnail --audio-format mp3 --audio-quality 0 --metadata-from-title="%(artist)s - %(title)s" --prefer-ffmpeg -o "%(title)s.%(ext)s"'';

      nrs = "sudo nixos-rebuild switch --fast --flake ${flakeDir}";
      nrb = "sudo nixos-rebuild boot --fast --flake ${flakeDir}";
      nrt = "sudo nixos-rebuild test --fast --flake ${flakeDir}";
      nfu = "nix flake update --flake ${flakeDir}";
      nss = "nix search nixpkgs";
      ngc = "sudo nix-collect-garbage --delete-old && nix-collect-garbage --delete-old";
      nsh = "nix-shell --run 'fish' --packages";
    };
}
