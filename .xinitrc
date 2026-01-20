#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap


# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

setxkbmap -option caps:escape

# 1. Start the lock screen manager in the background
# This ensures the screen locks if idle
xss-lock -- i3lock -n -c 000000 &

# 2. IMMEDIATELY lock the screen now so it's secure upon boot
i3lock -n -c 000000 &

# setxkbmap -layout us,tr -option grp:alt_shift_toggle
# nitrogen --restore %
xrdb -merge ~/.Xresources 
exec i3
