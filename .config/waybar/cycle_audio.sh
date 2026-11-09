#!/bin/bash

# Get a list of all active audio sinks
sinks=($(pactl list short sinks | awk '{print $2}'))

# Get the currently active sink
current=$(pactl get-default-sink)

# Find the current sink in the list and switch to the next one
for i in "${!sinks[@]}"; do
    if [[ "${sinks[$i]}" == "$current" ]]; then
        next=$(( (i + 1) % ${#sinks[@]} ))
        pactl set-default-sink "${sinks[$next]}"
        exit 0
    fi
done
