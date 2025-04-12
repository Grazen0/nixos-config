{
  config,
  lib,
  ...
}:
with config.scheme.withHashtag;
# scss
  ''
    * {
      all: unset;
    }

    .desktop-clock,
    .desktop-cow,
    .bar {
      font-family: "${config.theme.font.regular}";
      color: ${base05};
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
      background-color: ${base00};
      padding: 0 12px;

      .dim {
        color: ${base04};
        border-color: ${base04};
      }

      .sysmenu {
        color: ${blue};
        font-size: 1.5em;
      }

      .systray {
        margin: 0 10px;

        menu {
          background-color: ${base01};
          padding: 4px 0;

          > separator {
            background-color: transparent;
          }

          > * {
            padding: 4px 10px;

            &:disabled {
              color: ${base04};
            }

            &:hover:not(:disabled) {
              background-color: ${base03};
            }
          }
        }
      }

      .tags > * {
        padding: 0 12px;
        border-bottom: 2px solid transparent;

        &.empty {
          color: ${base04};
        }

        &.active {
          border-color: ${blue};
          color: ${blue};
        }

        &.urgent {
          color: ${magenta};
          border-color: ${magenta};
        }

        &.scratchpad {
          color: ${magenta};

          &.empty {
            opacity: 0;
          }

          &.active {
            color: ${magenta};
            border-color: ${magenta};
          }
        }
      }

      .bar-right > * {
        padding: 0 10px;
        border-bottom: 2px solid;
      }

      .volume {
        color: ${base06};
        border-color: ${base06};
      }

      .network {
        color: ${green};
        border-color: ${green};

        &.offline {
          color: ${red};
          border-color: ${red};
        }
      }

      .battery {
        color: ${cyan};
        border-color: ${cyan};

        &.charging {
          color: ${magenta};
          border-color: ${magenta};
        }

        &.critical {
          color: ${red};
          border-color: ${red};
        }
      }

      .time {
        color: ${yellow};
        border-color: ${yellow};
      }

      .notifications {
        color: ${base06};
        border-color: ${base06};
      }
    }

    tooltip {
      background-color: ${base00};
    }
  ''
