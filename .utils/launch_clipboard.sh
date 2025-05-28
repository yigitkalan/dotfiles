#!/bin/bash
killall rofi

cliphist list | rofi -dmenu | cliphist decode | wl-copy
