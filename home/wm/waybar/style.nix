{
  config,
  lib,
  lib',
  ...
}: let
  inherit (config) theme;
  colors = theme.colors.hexWithHashtag;
in
  # css
  ''
    /* GENERAL */
    * {
      font-family: ${theme.font.propo}, monospace;
      font-size: 12px;
      color: inherit;
      border-radius: 0;
      margin: 0;
      padding: 0;
      min-height: 0;
      transition: none;
    }

    window#waybar {
      background-color: ${colors.background};
      color: ${colors.foreground};
    }

    window#waybar.hidden {
      opacity: 0.2;
    }

    #custom-sysmenu,
    #tray,
    #language,
    #custom-media,
    #tags,
    #pulseaudio,
    #battery,
    #temperature,
    #network,
    #clock,
    #custom-notifications,
    #custom-power {
      margin: 0px 12px;
    }

    #custom-sysmenu:hover,
    #tray:hover,
    #language:hover,
    #custom-media:hover,
    #pulseaudio:hover,
    #battery:hover,
    #temperature:hover,
    #network:hover,
    #clock:hover,
    #custom-notifications:hover,
    #custom-power:hover {
      border-color: ${colors.blue};
    }

    /* SYSMENU */
    #custom-sysmenu {
      color: ${colors.brightBlue};
      font-size: 1.2em;
    }

    /* TRAY */
    #tray > .passive {
      -gtk-icon-effect: dim;
    }

    #tray > .needs-attention {
      -gtk-icon-effect: highlight;
    }

    /* LANGUAGE */
    #language {
      color: ${colors.white};
    }

    /* MEDIA */
    #custom-media {
      color: ${colors.magenta};
    }

    #custom-media.paused {
      color: ${colors.brightBlack};
    }

    #custom-media.inactive {
      opacity: 0;
    }

    /* TAGS */
    #tags {
      padding: 0 16px;
    }

    #tags button {
      padding: 0;
      min-width: 32px;
    }

    /* Disable default some GTK stuff */
    #tags button:hover {
      box-shadow: none;
      text-shadow: none;
      background: none;
      transition: none;
    }

    #tags button:not(.focused):not(.occupied) {
      color: ${colors.brightBlack};
    }

    #tags button.focused {
      background-color: ${colors.blue};
      color: ${colors.black};
    }

    #tags button.urgent {
      background-color: ${colors.magenta};
      color: ${colors.black};
    }

    /* Scratchpad stuff */
    #tags button:last-child:not(.occupied):not(.focused) {
      opacity: 0;
    }

    #tags button:last-child.occupied:not(.focused) {
      color: ${colors.brightMagenta};
    }

    #tags button:last-child.focused {
      background-color: ${colors.brightMagenta};
    }

    /* PULSEAUDIO */
    #pulseaudio.muted {
      color: ${colors.brightBlack};
    }

    /* NETWORK */
    #network {
      color: ${colors.green};
    }

    #network.disconnected {
      color: ${colors.red};
    }

    /* BATTERY */
    #battery.critical:not(.charging) {
      background-color: ${colors.red};
    }

    /* CLOCK */
    #clock {
      color: ${colors.yellow};
    }

    /* NOTIFICATIONS */
    #custom-notifications.paused {
      color: ${colors.brightBlack};
    }
  ''
