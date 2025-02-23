{
  config,
  pkgs,
  customPkgs,
  ...
}: {
  programs.fish.shellAliases = let
    flakeDir = "${config.xdg.configHome}/nixos";
    yt-dlp = "${pkgs.yt-dlp}/bin/yt-dlp";
    tmux-music = "${customPkgs.tmux-music}/bin/tmux-music";
  in {
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
    "...." = "cd ../../..";
    "....." = "cd ../../../..";

    grep = "grep --color=auto";

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
    gd = "git diff";
    gl = "git pull";
    gp = "git push";
    gpsup = "git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)";
    grh = "git reset";
    grs = "git restore";
    grst = "git restore --staged";
    gstaa = "git stash apply";
    gstp = "git stash pop";
    gst = "git status";

    cat = "bat";
    catfr = "${pkgs.coreutils}/bin/cat";

    rm = "rmtrash";
    rmdir = "rmdirtrash";
    rmfr = "${pkgs.coreutils}/bin/rm";
    rmdirfr = "${pkgs.coreutils}/bin/rmdir";
    restore = "trash-restore";

    v = "nvim";
    emacs = "nvim";
    emacss = "nvim -S";

    peaclock = "peaclock --config-dir ${config.xdg.configHome}/peaclock";
    lg = "lazygit";
    # "Borrowed" from https://github.com/NotAShelf/nyx/blob/main/homes/notashelf/programs/terminal/shell/zsh/aliases.nix#L39
    ytmp3 = ''${yt-dlp} -x -c --add-metadata --embed-thumbnail --audio-format mp3 --audio-quality 0 --metadata-from-title="%(artist)s - %(title)s" --prefer-ffmpeg -o "%(title)s.%(ext)s"'';
    music = "${tmux-music} ${../../../files/default_album_art.png}";

    R = "R --quiet --no-save";
    Rfr = "${config.programs.r.finalPackage}/bin/R";

    rbs = "sudo nixos-rebuild switch --flake ${flakeDir}";
    rbb = "sudo nixos-rebuild boot --flake ${flakeDir}";
    rbt = "sudo nixos-rebuild test --flake ${flakeDir}";
    upd = "nix flake update --flake ${flakeDir}";
    nss = "nix search nixpkgs";
    ngc = "nix-collect-garbage --delete-old && sudo nix-collect-garbage --delete-old";
  };
}
