{
  config,
  pkgs,
  ...
}: {
  programs.fish.shellAliases = let
    flakeDir = "${config.xdg.configHome}/nixos";
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

    "md" = "mkdir -p";
    "rd" = "rmdir";
    "rdfr" = "rmdirfr";
    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";
    "....." = "cd ../../../..";

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
    gcs = "git commit --gpg-sign";
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

    R = "R --quiet --no-save";

    rbs = "sudo nixos-rebuild switch --flake ${flakeDir}";
    rbb = "sudo nixos-rebuild boot --flake ${flakeDir}";
    rbt = "sudo nixos-rebuild test --flake ${flakeDir}";
    upd = "nix flake update --flake ${flakeDir}";
    nss = "nix search nixpkgs";

    # I'm kinda clumsy
    ":q" = "exit";
    ":x" = "exit";
  };
}
