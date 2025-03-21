{pkgs, ...}: {
  imports = [
    ../minimal
    ../../../components/common/theme
  ];

  environment.systemPackages = with pkgs; [
    lsof
    jq
    killall
    man-pages-posix
  ];

  programs = {
    fish.enable = true;

    # Use fish as "default" shell
    bash.interactiveShellInit =
      # bash
      ''
        if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
        then
          shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
          exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
        fi
      '';

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      settings = {
        # 7 days
        default-cache-ttl = 604800;
        max-cache-ttl = 604800;
      };
    };
  };
}
