sxhkd -c ~/.config/sxhkd/$SDF_STARTX_CMD/*.sxhkdrc &
unclutter &
/usr/bin/xautolock -time 5 -locker "/usr/bin/i3lock -c ff0000" &
feh --randomize --bg-tile $SDF_PATH/home/.config/wallpaper/repeatable/dark/*
systemctl --user import-environment DISPLAY
exec $SDF_STARTX_CMD
