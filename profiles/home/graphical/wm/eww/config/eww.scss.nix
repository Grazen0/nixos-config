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
    }

    .desktop-time,
    .desktop-fortune,
    .bar {
      font-family: "ComicShannsMono Nerd Font Propo";
      color: ${colors.foreground};
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

    .bar {
      font-size: 0.9rem;
      background-color: ${colors.background};
      padding: 0 12px;

      .sysmenu {
        color: ${colors.brightBlue};
        font-size: 1rem;
      }

      .systray {
        margin: 0 10px;
      }

      .tag {
        padding: 0 12px;

        &.empty {
          color: ${colors.brightBlack};
        }

        &.active {
          background-color: ${colors.blue};
          color: ${colors.black};
        }

        &.scratchpad {
          background-color: ${colors.magenta};
          color: ${colors.black};
        }

        &.scratchpad:not(.active) {
          opacity: 0;
        }
      }

      .notifications {
        min-width: 16px; // Muted icon is slightly wider

      }

      .time {
        color: ${colors.yellow};
      }

      .dim {
        color: ${colors.brightBlack};
      }
    }

    tooltip {
      background-color: ${colors.background};
    }
  ''
