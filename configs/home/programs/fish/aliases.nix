{ config, pkgs, ... }:
{
  programs.fish.shellAliases =
    let
      flakeDir = "${config.xdg.configHome}/nixos";
      yt-dlp = "${pkgs.yt-dlp}/bin/yt-dlp";
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

      grep = "grep --color=auto";
      ta = "tmux attach";
      lg = "lazygit";

      cat = "bat";
      catfr = "${pkgs.coreutils}/bin/cat";

      rm = "rmtrash";
      rmfr = "${pkgs.coreutils}/bin/rm";

      v = "nvim";
      vs = "nvim -S";

      # "Borrowed" from https://github.com/NotAShelf/nyx/blob/main/homes/notashelf/programs/terminal/shell/zsh/aliases.nix#L39
      ytmp3 = ''${yt-dlp} -x -c --add-metadata --embed-thumbnail --audio-format mp3 --audio-quality 0 --metadata-from-title="%(artist)s - %(title)s" --prefer-ffmpeg -o "%(title)s.%(ext)s"'';

      nrs = "sudo nixos-rebuild switch --no-reexec --accept-flake-config --flake ${flakeDir}";
      nrb = "sudo nixos-rebuild boot --no-reexec --accept-flake-config --flake ${flakeDir}";
      nrt = "sudo nixos-rebuild test --no-reexec --accept-flake-config --flake ${flakeDir}";
      nfu = "nix flake update --flake ${flakeDir}";
      nss = "nix search nixpkgs";
      ngc = "sudo nix-collect-garbage --delete-old && nix-collect-garbage --delete-old";
      nsh = "nix-shell --run 'fish' --packages";
    };
}
