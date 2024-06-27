#!/bin/bash

# Get current wallpaper path
current_wallpaper=$(grep '^wallpaper =' ~/.config/waypaper/config.ini | cut -d '=' -f2 | tr -d ' ')

# Expand the tilde to the home directory
current_wallpaper="${current_wallpaper/#\~/$HOME}"

# Generate color scheme from current wallpaper
wal -i "$current_wallpaper" 

# Reload Hyprland config
hyprctl reload 

# Restart waybar
killall waybar
waybar & 
