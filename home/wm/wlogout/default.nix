{
  config,
  lib,
  ...
}: {
  programs.wlogout = {
    enable = false;

    style = let
      inherit (config) theme;
      colors = theme.colors.hexWithHashtag;
      buttons = [
        "lock"
        "logout"
        "suspend"
        "hibernate"
        "shutdown"
        "reboot"
      ];

      buttonCss = map (btn:
        # css
        ''
          #${btn} {
            background-image: url('${./icons/${btn}.png}');
          }

          #${btn}:focus, #${btn}:active {
            background-image: url('${./icons/${btn}-hover.png}');
          }
        '')
      buttons;
    in
      # css
      ''
        * {
          background-image: none;
          box-shadow: none;
        }

        window {
          background-color: rgba(12, 12, 12, 0.75);
        }

        button {
          transition: none;
          font-family: ${theme.font.regular};
          font-size: 1.25rem;
          margin: 6px;

          border: solid 3px ${colors.blue};
          border-radius: 0;

          color: ${colors.foreground};

          background-color: ${colors.background};
          background-repeat: no-repeat;
          background-position: center;
          background-size: 25%;
        }

        button:focus,
        button:active {
          background-color: ${colors.blue};
          color: ${colors.background};
          outline-style: none;
        }

        ${lib.concatStringsSep "\n" buttonCss}
      '';
  };
}
