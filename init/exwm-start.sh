#!/bin/sh

# Disable access control
xhost +SI:localuser:$USER

# Make Java applications aware this is a non-reparenting window manager.
export _JAVA_AWT_WM_NONREPARENTING=1

# Themes, etc
gnome-settings-daemon &

# Fallback cursor
xsetroot -cursor_name left_ptr

# Keyboard repeat rate
xset r rate 300 70

# Capslock ctrl key
setxkbmap -layout gb -option ctrl:nocaps

# SSH agent essentials
eval `ssh-agent -s`

# Start Emacs
exec dbus-launch --exit-with-session emacs
