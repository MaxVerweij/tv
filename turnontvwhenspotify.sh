#!/bin/bash
# Meant for polling. When spotify is playing: turn on tv if connected

while true; do
  if playerctl -l -s | grep -q spotifyd; then 
    if [ "$(playerctl -p spotifyd status)" = "Playing" ]; then
      echo "spotify is playing"
      if [[ "$(echo "status" | nc 127.0.0.1 65432)" == "True" ]]; then
        echo "tv turned on"
      else
        echo "tv turned off"
        echo "turnontv" | nc 127.0.0.1 65432
      fi
    fi
  else
    echo "spotifyd is not running"
  fi
  sleep 5
done
