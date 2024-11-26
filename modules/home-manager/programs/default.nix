{theme, ...}: {
  imports = [
    ./neovim
    ./vesktop
    ./bat.nix
    ./btop.nix
    ./cava.nix
    ./direnv.nix
    ./fastfetch.nix
    ./foot.nix
    ./git.nix
    ./idea.nix
    ./mpv.nix
    ./peaclock.nix
    ./spicetify.nix
    ./swayimg.nix
    ./tmux.nix
    ./yazi.nix
    ./zapzap.nix
    ./zathura.nix
  ];

  programs = {
    broot.enable = true;
    eza.enable = true;
    obs-studio.enable = true;
    lazygit.enable = true;

    # TODO: refactor everything as it should go
    peaclock = {
      enable = true;

      extraConfig = ''
        # -------------
        # general
        # -------------

        # set the x y block size, the width and height of an individual block composing
        # the clock
        block 2 1
        # block-x 2
        # block-y 1

        # set the x y padding size, the width and height of the space between each
        # individual block composing the clock
        padding 0 0
        # padding-x 0
        # padding-y 0

        # set the x y margin size, the space around the outside of the clock from the
        # edge of the terminal
        margin 0 0
        # margin-x 0
        # margin-y 0

        # set the x y ratio size, auto adjust the clock to conform to a specific
        # aspect ratio, keep in mind that a square ratio would be '2 1' due to a
        # terminal character cell having a height around twice the size of its width
        ratio 2 1
        # ratio-x 2
        # ratio-y 1

        # set the padding size between the date and the clock
        date-padding 1

        # set the string value used to fill the active, inactive, and colon blocks of
        # the clock, an empty string clears the value
        fill '''
        # fill-active '''
        # fill-inactive '''
        # fill-colon '''

        # set the date format string, an empty string clears the value
        date '%a. %B %d'

        # set the mode type
        # select one of:
        # clock, timer, or stopwatch
        mode clock

        # set the view type
        # select one of:
        # date, ascii, digital, binary, or icon
        view digital

        # set the value to adjust with the hjkl;' keys
        # select one of:
        # block, padding, margin, ratio, active-fg, inactive-fg, colon-fg,
        # active-bg, inactive-bg, colon-bg, background, or date
        toggle active-bg

        # set the stopwatch to start
        # clear, stop, start, 00h:00m:00s
        stopwatch start

        # set the timers initial value
        # clear, stop, start, 00h:00m:00s
        timer 10m:0s

        # set the string value to be executed by a shell upon timer completion,
        # an empty string clears the value
        timer-exec 'notify-send -a peaclock "timer complete"'

        # set the duration in milliseconds between reading user input
        rate-input 50

        # set the duration in milliseconds between redrawing the output
        rate-refresh 1000

        # set the duration in milliseconds to display status messages
        rate-status 5000

        # -------------
        # toggles
        # -------------

        # use 24 hour time
        set hour-24 on

        # display seconds
        set seconds off

        # display the date
        set date on

        # auto size the clock to fill the screen, overrides the current x y block size
        set auto-size on

        # auto size the clock to use the aspect ratio set by the command 'ratio',
        # overrides the current x y block size and auto-size
        set auto-ratio on

        # -------------
        # styles
        # -------------

        # set the style of the text set by the command 'fill' used to draw active
        # blocks in the clock
        style active-fg yellow bright

        # set the style of the text set by the command 'fill' used to draw inactive
        # blocks in the clock
        style inactive-fg clear

        # set the style of the text set by the command 'fill-colon' used to draw colon
        # blocks in the clock
        style colon-fg clear

        # set the style of the background used to draw active blocks in the clock
        style active-bg reverse

        # set the style of the background used to draw inactive blocks in the clock
        style inactive-bg clear

        # set the style of the background used to draw colon blocks in the clock
        style colon-bg yellow bright

        # set the style of the date
        style date yellow

        # set the style of the background
        style background clear

        # set the style of the text
        style text green

        # set the style of the command prompt symbol shown at the start of the line
        style prompt clear

        # set the style of the prompt status on success
        style success green

        # set the style of the prompt status on error
        style error red
      '';
    };

    swayimg = {
      enable = true;

      settings = let
        colors = theme.colors.hex;
      in {
        viewer = {
          window = colors.background;
          antialiasing = "yes";
        };

        gallery = {
          window = colors.background;
          antialiasing = "yes";
        };

        font = {
          name = "JetBrainsMonoNL Nerd Font";
          size = 18;
          color = colors.brightWhite;
          shadow = colors.black;
        };

        info.show = "no";

        "keys.viewer" = {
          p = "prev_file";
          n = "next_file";

          g = "first_file";
          "Shift+g" = "last_file";

          h = "step_left 10";
          j = "step_down 10";
          k = "step_up 10";
          l = "step_right 10";

          "Shift+j" = "zoom -10";
          "Shift+k" = "zoom +10";
        };

        "keys.gallery" = {
          g = "first_file";
          "Shift+g" = "last_file";

          h = "step_left";
          j = "step_down";
          k = "step_up";
          l = "step_right";

          "Shift+j" = "page_down";
          "Shift+k" = "page_up";
        };
      };
    };

    zapzap = {
      enable = true;

      settings = {
        notification.app = true;

        storage-whats.notification = true;

        system = {
          background_message = true;
          donation_message = false;
          folderDownloads = true;
          hide_bar_users = true;
          theme = "dark";
        };
      };
    };
  };
}
