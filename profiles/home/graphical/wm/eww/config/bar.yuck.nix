{
  config,
  lib,
  lib',
  pkgs,
  customPkgs,
  inputs,
  ...
}: let
  inherit (config) theme;

  cfg = config.meta.eww;

  uniqqPkg = pkgs.callPackage ../scripts/uniqq.nix {};
  uniqq = "${uniqqPkg}/bin/uniqq";

  networkPkg = pkgs.callPackage ../scripts/network.nix {};
  network = "${networkPkg}/bin/network";

  pamixer = "${pkgs.pamixer}/bin/pamixer";

  ristate = let
    ristatePkg = pkgs.ristate.override (prev: {
      rustPlatform =
        prev.rustPlatform
        // {
          buildRustPackage = args:
            prev.rustPlatform.buildRustPackage (args
              // {
                src = inputs.ristate;
                cargoHash = "sha256-6uvIc69x/yHkAC3GJUuYGcCbpVyX/mb/pXLf+BQC+48=";
              });
        };
    });
  in "${ristatePkg}/bin/ristate";
in
  # yuck
  ''
    (defwindow bar-primary
      :monitor 0
      :geometry (geometry :anchor "top center" :width "100%" :height 26)
      :stacking "bg"
      :exclusive true
      :namespace "eww-desktop"
      (bar :monitor "${cfg.outputs.primary}"))

    (defwindow bar-secondary
      :monitor 1
      :geometry (geometry :anchor "top center" :width "100%" :height 26)
      :stacking "bg"
      :exclusive true
      :namespace "eww-desktop"
      (bar :monitor "${cfg.outputs.secondary}"))

    (defvar clock-date false)

    (defwidget bar [monitor]
      (centerbox
        :class "bar"
        (bar-left)
        (bar-middle :monitor {monitor})
        (bar-right)))

    (defwidget bar-left []
        (box
          :space-evenly false
          :spacing 12
          (button :class "sysmenu" :onclick "fuzzel &" "")
          (systray :class "systray" :spacing 6 :icon-size 18)))

    (deflisten tags :initial "{}"
      `${uniqq} ${ristate} --tags`)

    (deflisten views-tag :initial "{}"
      `${uniqq} ${ristate} --views-tag`)

    (defwidget tag-button [n monitor ?class ?text]
      (button
        :class "''${class} ''${jq(tags.tags[monitor], 'index("''${n}") != null')
          ? "active"
          : jq(views-tag.viewstag[monitor], 'index(''${n}) == null')
            ? "empty"
            : ""}"
        :onclick "riverctl set-focused-tags ''${powi(2, n - 1)}"
        :onrightclick "riverctl toggle-focused-tags ''${powi(2, n - 1)}"
        {text ?: n}))


    (defwidget bar-middle [monitor]
        (box
          :space-evenly false
          :class "tags"
          (tag-button :n 1 :monitor {monitor})
          (tag-button :n 2 :monitor {monitor})
          (tag-button :n 3 :monitor {monitor})
          (tag-button :n 4 :monitor {monitor})
          (tag-button :n 5 :monitor {monitor})
          (tag-button :n 6 :monitor {monitor})
          (tag-button :n 7 :monitor {monitor})
          (tag-button :n 8 :monitor {monitor})
          (tag-button :n 9 :monitor {monitor})
          (tag-button
            :n 10
            :class "scratchpad"
            :text "S"
            :monitor {monitor})
        ))

    (defwidget icon-metric [icon ?onclick ?tooltip ?class ?spacing]
      (button
        :onclick {onclick}
        :class {class}
        :tooltip {tooltip}
        (box
          :space-evenly false
          :spacing {spacing ?: 12}
          icon
          (children))))

    (defpoll notifs-paused :interval "2s" :initial "false"
      `dunstctl is-paused`)

    (defpoll volume :interval "1s"
      `${pamixer} --get-volume`)

    (defpoll volume-mute :interval "1s"
      `${pamixer} --get-mute`)

    (defpoll volume-sink :interval "5s"
      `${pamixer} --get-default-sink | awk -F'"' '{print $4}'`)

    (defwidget battery-metric [status capacity]
      (icon-metric
        :class "battery ''${status == "Discharging" ? "" : "charging"}"
        :tooltip {status}
        :icon {status == "Discharging"
          ? capacity < 10
            ? "󰁺"
            : capacity < 20
              ? "󰁻"
              : capacity < 30
                ? "󰁼"
                : capacity < 40
                  ? "󰁽"
                  : capacity < 50
                    ? "󰁾"
                    : capacity < 60
                      ? "󰁿"
                      : capacity < 70
                        ? "󰂀"
                        : capacity < 80
                          ? "󰂁"
                            : capacity < 90
                              ? "󰂂"
                              : "󰁹"
          : capacity < 10
            ? "󰢜"
            : capacity < 20
              ? "󰂆"
              : capacity < 30
                ? "󰂇"
                : capacity < 40
                  ? "󰂈"
                  : capacity < 50
                    ? "󰢝"
                    : capacity < 60
                      ? "󰂉"
                      : capacity < 70
                        ? "󰢞"
                        : capacity < 80
                          ? "󰂊"
                            : capacity < 90
                              ? "󰂋"
                              : "󰂅"}
        "''${capacity}%"))

    (defpoll network-info :interval "1s" `${network}`)

    (defwidget network-metric [info]
      (icon-metric
        :class "network ''${info.type == "null" ? "offline" : ""}"
        :onclick "nm-connection-editor"
        :tooltip {info.device}
        :icon {info.type == "null"
          ? "󰤮"
          : info.type == "ethernet"
            ? "󰈀"
            : info.strength < 10
              ? "󰤯"
              : info.strength < 30
                ? "󰤟"
                : info.strength < 50
                  ? "󰤢"
                  : info.strength < 80
                    ? "󰤥"
                    : "󰤨"}
        {info.type == "null"
          ? "Offline"
          : info.type == "ethernet"
            ? "ethernet"
            : "''${info.strength}%"}))

    (defwidget bar-right []
        (box
          :class "bar-right"
          :space-evenly false
          :spacing 4
          :halign "end"
          (icon-metric
            :onclick "${pamixer} --toggle-mute && eww poll volume-mute"
            :tooltip {volume-sink}
            :class {volume-mute ? "dim" : "volume"}
            :icon {volume-mute
              ? ""
              : volume < 20
                ? ""
                : volume < 60
                  ? ""
                  : ""}
            "''${volume}%")
          (network-metric :info {network-info})
          (battery-metric
            :status {EWW_BATTERY.${cfg.battery}.status}
            :capacity {EWW_BATTERY.${cfg.battery}.capacity})
          (icon-metric
            :class "time"
            :onclick "eww update clock-date=''${!clock-date}"
            :icon {clock-date ? "" : ""}
            {formattime(EWW_TIME, clock-date ? "%d/%m/%y" : "%I:%M %p")})
          (button
            :class {notifs-paused ? "dim" : "notifications"}
            :style "font-family: ${theme.font.propo}"
            :width 35
            :onclick "dunstctl set-paused toggle && eww poll notifs-paused"
            :tooltip "Toggle notifications"
            {notifs-paused ? "" : ""})))
  ''
