{ config, ... }:
let
  inherit (config) theme;
in
with config.scheme.withHashtag;
# css
''
  /* GENERAL */
  * {
    font-family: ${theme.font.propo}, monospace;
    font-size: 13px;
    color: inherit;
    border-radius: 0;
    margin: 0;
    padding: 0;
    min-height: 0;
    transition: none;
  }

  window#waybar {
    background-color: ${base00};
    color: ${base06};
  }

  window#waybar.hidden {
    opacity: 0.2;
  }

  #pulseaudio,
  #memory,
  #network,
  #battery,
  #clock,
  #custom-notifications,
  #custom-power {
    margin: 0 2px;
    padding: 0px 10px;
    border-bottom: 2px solid;
  }

  /* SYSMENU */
  #custom-sysmenu {
    color: ${bright-blue};
    margin-left: 10px;
    font-size: 1.5em;
  }

  /* TRAY */
  #tray {
    margin: 0 8px;
  }

  /* MEDIA */
  #custom-media {
    color: ${magenta};
  }

  #custom-media.paused {
    color: ${base04};
  }

  #custom-media.inactive {
    opacity: 0;
  }

  /* RIVER TAGS */
  #tags {
    padding: 0 16px;
  }

  #tags button {
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
    color: ${base04};
  }

  #tags button.focused {
    background-color: ${blue};
    color: ${base01};
  }

  #tags button.urgent {
    background-color: ${magenta};
    color: ${base01};
  }

  /* Scratchpad stuff */
  #tags button:last-child:not(.occupied):not(.focused) {
    opacity: 0;
  }

  #tags button:last-child.occupied:not(.focused) {
    color: ${bright-magenta};
  }

  #tags button:last-child.focused {
    background-color: ${bright-magenta};
  }

  /* HYPRLAND WORKSPACE */
  #workspaces {
    margin: 0 16px;
  }

  #workspaces button {
    min-width: 32px;
    border-bottom: 2px solid;
    border-color: transparent;
  }

  /* Disable default some GTK stuff */
  #workspaces button:hover {
    box-shadow: none;
    text-shadow: none;
    background: none;
    transition: none;
  }

  #workspaces button.visible,
  #workspaces button.active {
    color: ${blue};
    border-color: ${blue};
  }

  #workspaces button.urgent {
    color: ${orange};
    border-color: ${orange};
  }

  #workspaces button.empty:not(.visible):not(.active) {
    color: ${base04};
  }

  /* PULSEAUDIO */
  #pulseaudio {
    color: ${magenta};
    border-color: ${magenta};
    min-width: 42px; /* Ensure consistent width */
  }

  #pulseaudio.muted {
    color: ${base04};
    border-color: ${base04};
  }

  /* MEMORY */
  #memory {
    color: ${blue};
    border-color: ${blue};
  }

  /* NETWORK */
  #network {
    color: ${cyan};
    border-color: ${cyan};
  }

  #network.disconnected {
    color: ${red};
    border-color: ${red};
  }

  /* BATTERY */
  #battery.plugged {
    color: ${green};
    border-color: ${green};
  }

  #battery.critical:not(.charging) {
    color: ${red};
    border-color: ${red};
  }

  /* CLOCK */
  #clock {
    color: ${yellow};
    border-color: ${yellow};
  }

  #clock .icon {
  background-color: red;
  }

  /* NOTIFICATIONS */
  #custom-notifications {
    color: ${orange};
    border-color: ${orange};
    min-width: 14px; /* Ensure consistent width */
  }

  #custom-notifications.paused {
    color: ${base04};
    border-color: ${base04};
  }

  #custom-power {
    color: ${red};
    border-color: ${red};
    margin-right: 10px;
  }
''
