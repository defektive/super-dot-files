systemctl --user import-environment DISPLAY &
compton &
feh --randomize --bg-tile $HOME/.config/wallpaper/repeatable/dark/* &

sxhkd -c ~/.config/sxhkd/default/* &
polybar -r -c ~/.config/polybar/config qhd &

/usr/bin/xautolock -time 5 -locker "/usr/bin/i3lock -c ff0000" &

exec bspwm
