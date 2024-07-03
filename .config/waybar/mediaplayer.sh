#!/bin/sh

player_status=$(playerctl status 2> /dev/null)
if [ "$player_status" = "Playing" ]; then
    player_artist=$(playerctl metadata artist)
    player_title=$(playerctl metadata title)

    if [ ${#player_artist} -gt 0 ]; then
        echo '{"text": "'" ⏸️ $player_artist - $player_title ⏭️"'", "class": "playing", "alt": "Playing"}'
    else
        echo '{"text": "'" ⏸️ $player_title ⏭️"'", "class": "playing", "alt": "Playing"}'
    fi
elif [ "$player_status" = "Paused" ]; then
    player_artist=$(playerctl metadata artist)
    player_title=$(playerctl metadata title)
    
    if [ ${#player_artist} -gt 0 ]; then
        echo '{"text": "'" ▶️ $player_artist - $player_title ⏭️"'", "class": "paused", "alt": "Paused"}'
    else
        echo '{"text": "'" ▶️ $player_title ⏭️"'", "class": "paused", "alt": "Paused"}'
    fi
else
    echo '{"text": "No media ▶️ ⏭️", "class": "stopped", "alt": "Stopped"}'
fi
