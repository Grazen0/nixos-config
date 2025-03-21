{
  config,
  lib,
  ...
}: let
  inherit (config) theme;
  colors = theme.colors.hexWithHashtag;
in
  # scss
  ''
    * {
      all: unset;
      font-family: "${theme.font.propo}";
      color: ${colors.brightWhite};
    }

    .desktop-time {
      .time {
        font-weight: bold;
        font-size: 5em;
        margin-bottom: 0.5rem;
      }

      .date {
        font-size: 1.5em;
      }
    }

    .desktop-fortune {
      font-size: 1.05em;
    }

    .desktop-player {

      .art {
        background-size: cover;
      }
    }

    .volume-bar {
      background-color: ${colors.background};
      padding: 1.5em;

      .slider {
        margin-bottom: 1em;

        trough {
          background-color: ${colors.backgroundAlt};
          min-height: 10em;
          min-width: 1em;

          highlight {
            opacity: 0;
            background-color: ${colors.blue};
            min-height: 1em;
          }
        }
      }
    }
  ''
