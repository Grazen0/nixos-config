{ pkgs, ... }:
let
  fortune = "${pkgs.fortune}/bin/fortune";
  cowsay = "${pkgs.cowsay}/bin/cowsay";
in
# yuck
''
  (defpoll fortune :interval "15m"
    `${fortune} -s | ${cowsay} | sed 's/\\\\/\\\\\\\\/g'`)

  (defwindow desktop-clock
    :monitor 0
    :geometry (geometry :anchor "center right" :x "6%")
    :stacking "bg"
    (desktop-clock))

  (defwidget desktop-clock []
    (box :class "desktop-time" :orientation "v" :space-evenly false
      (label :class "time" :text {formattime(EWW_TIME, "%I:%M %p")})
      (label :class "date" :text {formattime(EWW_TIME, "%A, %B %-d %p")})))


  (defwindow desktop-cow
    :monitor 0
    :geometry (geometry :anchor "bottom left" :x 64 :y 16)
    :stacking "bg"
    :namespace "eww-desktop"
    (desktop-cow))

  (defwidget desktop-cow []
    (label :text {fortune}))
''
