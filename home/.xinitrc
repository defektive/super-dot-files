mkdir -p $HOME/.local/share/sdf

systemctl --user import-environment DISPLAY &
# picom &
feh --randomize --bg-tile $HOME/.config/wallpaper/repeatable/dark/* &

start-pulseaudio-x11 &
sxhkd -c ~/.config/sxhkd/default/* &
sdf_polybar &

/usr/bin/xautolock -time 5 -locker "/usr/bin/i3lock -c ff0000" &

exec bspwm
