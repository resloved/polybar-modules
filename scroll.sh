#!/bin/bash

player_status=$(playerctl status 2> /dev/null)
if [[ $? -eq 0 ]]; then
    metadata="$(playerctl metadata artist) - $(playerctl metadata title) "
fi

modifier=4
length=${#metadata}
# milliseconds
cur=$(($(date +%s%3N)/100))
split=$(($cur/modifier%$length))
scrolled=${metadata:$split}${metadata:0:$split}

# Foreground color formatting tags are optional
if [[ $player_status = "Playing" ]]; then
    echo "%{F#7baa14}$scrolled"       # Orange when playing
elif [[ $player_status = "Paused" ]]; then
    echo "%{F#8a8a8a}$scrolled"       # Greyed out info when paused
fi
