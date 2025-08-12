{ config, ... }:
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

  tooltip {
    background-color: ${base01};
    border: solid 2px ${base03};
    padding: 4px 12px
  }

  .bar {
    font-size: 0.9em;
    background-color: ${base00};
    padding: 0 12px;

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

    .player {
      color: ${brown};
      border-color: ${brown};

      &.paused {
        color: ${base04};
        border-color: ${base04};
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
        color: ${orange};
        border-color: ${orange};
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

    .memory,
    .volume,
    .network,
    .battery,
    .clock,
    .notifications,
    .power-menu {
      padding: 0 10px;
      border-bottom: 2px solid;
    }

    .memory {
      color: ${blue};
      border-color: ${blue};
    }

    .volume {
      color: ${magenta};
      border-color: ${magenta};

      scale trough {
        min-height: 4px;
        background-color: ${base03};

        highlight {
          background-color: ${magenta};
        }
      }

      &.mute {
        color: ${base04};
        border-color: ${base04};

        scale trough highlight {
          background-color: ${base04};
        }
      }
    }

    .network {
      color: ${cyan};
      border-color: ${cyan};

      &.offline {
        color: ${red};
        border-color: ${red};
      }
    }

    .battery {
      color: ${base06};
      border-color: ${base06};

      &.charging {
        color: ${green};
        border-color: ${green};
      }

      &.critical {
        color: ${red};
        border-color: ${red};
      }
    }

    .clock {
      color: ${yellow};
      border-color: ${yellow};
    }

    .notifications {
      color: ${orange};
      border-color: ${orange};

      &.paused {
        color: ${base04};
        border-color: ${base04};
      }
    }

    .power-menu {
      color: ${red};
      border-color: ${red};
    }
  }
''
