{ config, ... }:
with config.scheme.withHashtag;
# scss
''
  * {
    all: unset;
  }

  .desktop-clock,
  .desktop-cow {
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
''
