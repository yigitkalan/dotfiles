#!/bin/bash

########### hyprland

# # Get current wallpaper path
# current_wallpaper=$(grep '^wallpaper =' ~/.config/waypaper/config.ini | cut -d '=' -f2 | tr -d ' ')
#
# # Expand the tilde to the home directory
# current_wallpaper="${current_wallpaper/#\~/$HOME}"
#
# # Generate color scheme from current wallpaper
# wal -i "$current_wallpaper" 
#
# # Reload Hyprland config
# hyprctl reload 
#
# # Restart waybar
# killall waybar
# waybar & 

########## i3
# Get current wallpaper path from Nitrogen's config
current_wallpaper=$(grep '^file=' ~/.config/nitrogen/bg-saved.cfg | head -n 1 | cut -d '=' -f2)

# Generate color scheme from current wallpaper
wal -i "$current_wallpaper"

# Reload i3 config
i3-msg reload

# Restart any bar (e.g., i3bar or polybar if you use it)
# If using polybar, uncomment the following lines:
# killall polybar
# polybar &

# If using i3bar, no need to restart it separately as `i3-msg reload` handles it
