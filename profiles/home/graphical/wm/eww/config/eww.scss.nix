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

    .desktop-clock,
    .desktop-cow,
    .bar {
      font-family: "${theme.font.regular}";
      color: ${colors.foreground};
    }

    .desktop-clock {
      .time {
        font-weight: bold;
        font-size: 5em;
        margin-bottom: 0.1em;
      }

      .date {
        font-size: 1.5em;
      }
    }

    .desktop-cow {
      font-size: 1.05em;
    }

    .bar {
      font-size: 0.9em;
      background-color: ${colors.background};
      padding: 0 12px;

      .dim {
        color: ${colors.brightBlack};
        border-color: ${colors.brightBlack};
      }

      .sysmenu {
        color: ${colors.blue};
        font-size: 1.5em;
      }

      .systray {
        margin: 0 10px;

        menu {
          background-color: ${colors.black};
          padding: 4px 0;

          > separator {
            background-color: transparent;
          }

          > * {
            padding: 4px 10px;

            &:disabled {
              color: ${colors.brightBlack};
            }

            &:hover:not(:disabled) {
              background-color: ${colors.backgroundAlt};
            }
          }
        }
      }

      .tags > * {
        padding: 0 12px;
        border-bottom: 2px solid transparent;

        &.empty {
          color: ${colors.brightBlack};
        }

        &.active {
          border-color: ${colors.blue};
          color: ${colors.blue};
        }

        &.urgent {
          color: ${colors.magenta};
          border-color: ${colors.magenta};
        }

        &.scratchpad {
          color: ${colors.magenta};

          &.empty {
            opacity: 0;
          }

          &.active {
            color: ${colors.magenta};
            border-color: ${colors.magenta};
          }
        }
      }

      .bar-right > * {
        padding: 0 10px;
        border-bottom: 2px solid;
      }

      .volume {
        color: ${colors.white};
        border-color: ${colors.white};
      }

      .network {
        color: ${colors.green};
        border-color: ${colors.green};

        &.offline {
          color: ${colors.red};
          border-color: ${colors.red};
        }
      }

      .battery {
        color: ${colors.cyan};
        border-color: ${colors.cyan};

        &.charging {
          color: ${colors.magenta};
          border-color: ${colors.magenta};
        }

        &.critical {
          color: ${colors.red};
          border-color: ${colors.red};
        }
      }

      .time {
        color: ${colors.yellow};
        border-color: ${colors.yellow};
      }

      .notifications {
        color: ${colors.white};
        border-color: ${colors.white};
      }
    }

    tooltip {
      background-color: ${colors.background};
    }
  ''
