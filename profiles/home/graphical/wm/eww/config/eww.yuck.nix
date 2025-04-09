{
  config,
  lib,
  lib',
  pkgs,
  customPkgs,
  inputs,
  ...
}: let
  # TODO: share this with osConfig via meta.timeZone
  timeZone = "America/Lima";
  fortune = "${pkgs.fortune}/bin/fortune";
  cowsay = "${pkgs.cowsay}/bin/cowsay";
  fuzzel-power-menu = "${customPkgs.fuzzel-power-menu}/bin/fuzzel-power-menu";
  dunstctl = "${config.services.dunst.package}/bin/dunstctl";
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
    (defpoll fortune :interval "15m"
      `${fortune} -s | ${cowsay} | sed 's/\\\\/\\\\\\\\/g'`)

    (defwindow desktop-time
      :monitor 0
      :geometry (geometry :anchor "center right" :x "6%")
      :stacking "bg"
      :namespace "eww-desktop"
      (desktop-time))

    (defwindow desktop-time-alt
      :monitor 0
      :geometry (geometry :anchor "center right" :x "5%")
      :stacking "bg"
      :namespace "eww-desktop"
      (desktop-time))

    (defwidget desktop-time []
      (box :class "desktop-time" :orientation "v" :space-evenly false
        (label :class "time" :text {formattime(EWW_TIME, "%I:%M %p")})
        (label :class "date" :text {formattime(EWW_TIME, "%A, %B %-d %p")})))


    (defwindow desktop-fortune
      :monitor 0
      :geometry (geometry :anchor "bottom left" :x 64 :y 16)
      :stacking "bg"
      :namespace "eww-desktop"
      (desktop-fortune))

    (defwidget desktop-fortune []
      (label :text {fortune}))

    (defwindow bar-primary
      :monitor 0
      :geometry (geometry :anchor "top center" :width "100%" :height 24)
      :stacking "bg"
      :exclusive true
      :namespace "eww-desktop"
      (bar :monitor "BOE"))

    (defwindow bar-secondary
      :monitor 1
      :geometry (geometry :anchor "top center" :width "100%" :height 24)
      :stacking "bg"
      :exclusive true
      :namespace "eww-desktop"
      (bar :monitor "BOE"))

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
      `${ristate} --tags`)

    (deflisten views-tag :initial "{}"
      `${ristate} --views-tag`)

    (defwidget tag-button [n monitor ?extra-class ?text]
      (button
        :class "tag ''${extra-class} ''${jq(tags.tags[monitor], 'index("''${n}") != null') ? "active" : ""} ''${jq(views-tag.viewstag[monitor], 'index(''${n}) == null') ? "empty" : ""}"
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
            :extra-class "scratchpad"
            :text "S"
            :monitor {monitor})
        ))

    ;; TODO: implement
    ;; (defwidget icon-metric [icon, text]
    ;;   ())

    (defpoll notifs-paused :interval "5s"
      `${dunstctl} is-paused`)

    (defpoll volume :interval "1s"
      `${pamixer} --get-volume`)

    (defpoll volume-mute :interval "1s"
      `${pamixer} --get-mute`)

    (defpoll volume-sink :interval "5s"
      `${pamixer} --get-default-sink | awk -F'"' '{print $4}'`)

    (defwidget bar-right []
        (box
          :space-evenly false
          :halign "end"
          :spacing 20
          (button
            :onclick "${pamixer} --toggle-mute && eww poll volume-mute"
            :tooltip {volume-sink}
            :class {volume-mute ? "dim" : ""}
            "''${volume == 0 ? "" : volume < 50 ? "" : ""} ''${volume}%")
          " ''${round(EWW_BATTERY.total_avg, 0)}%"
          (button
            :class "time"
            :onclick "eww update clock-date=''${!clock-date}"
            "''${clock-date ? "" : ""} ''${formattime(EWW_TIME, clock-date ? "%d/%m/%y")}")
          (button
            :class "notifications ''${notifs-paused ? "dim" : ""}"
            :onclick "${dunstctl} set-paused toggle && eww poll notifs-paused"
            {notifs-paused ? "" : ""})
          (button
            :active true
            :onclick "${fuzzel-power-menu}"
            "")))
  ''
