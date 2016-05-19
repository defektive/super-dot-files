xrdb -merge $HOME/.Xresources

xrandr --output eDP1 --off --output DP1 --auto

exec bspwm
