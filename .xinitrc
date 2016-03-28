
xrdb -merge /home/brad/.Xresources
#xrandr --output Virtual1 --auto --mode 2560x1600
xrandr --output eDP1 --scale .6x.6
exec bspwm
