{
  writeShellApplication,
  jq,
  networkmanager,
  ...
}:
writeShellApplication {
  name = "network";
  runtimeInputs = [
    jq
    networkmanager
  ];
  text = ''
    active_connections=$(nmcli -t -f TYPE,DEVICE connection show --active)
    ethernet_device=$(echo "$active_connections" | { grep 'ethernet:' || true; } | awk -F ':' '{print $2}')

    if [ -n "$ethernet_device" ]; then
      jq -nrc \
        --arg type "ethernet" \
        --arg device "$ethernet_device" \
        '$ARGS.named'
    else
      # Get the wifi device
      conn_info=$(nmcli -t -f DEVICE,CONNECTION,TYPE,STATE device | { grep ':wifi:connected$' || true; })
      wifi_device=$(echo "$conn_info" | awk -F ':' '{print $1}')

      if [ -n "$wifi_device" ]; then
        signal_strength=$(nmcli -t -f IN-USE,SIGNAL device wifi list ifname "$wifi_device" | grep '^\*' | awk -F ':' '{print $2}')

        if [ -n "$signal_strength" ]; then
          ssid=$(echo "$conn_info" | awk -F ':' '{print $2}')

          jq -nrc \
            --arg type "wifi" \
            --arg device "$wifi_device" \
            --arg ssid "$ssid" \
            --argjson strength "$signal_strength" \
            '$ARGS.named'
        else
          echo "{}"
        fi
      else
        echo "{}"
      fi
    fi
  '';
}
