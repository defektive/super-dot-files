xrdb -merge $HOME/.Xresources
xrandr --setprovideroutputsource modesetting NVIDIA-0

sdf_monitors internal
eval `dbus-launch`

LOG_PATH=~/.local/share/sdf/logs
mkdir -p $LOG_PATH

echo > $LOG_PATH/${SDF_STARTX_CMD}.sxhkd.log
sxhkd -c ~/.config/sxhkd/${SDF_STARTX_CMD}/* &

#-r $LOG_PATH/${SDF_STARTX_CMD}.sxhkd.log &
#sxhkd -c ~/.config/sxhkd/sdf.sxhkdrc -r $LOG_PATH/${SDF_STARTX_CMD}.sxhkd.log &

~/.feh-bg || feh --bg-tile ~/.config/bspwm/wallpaper/repeatable/random_grey_variations/random_grey_variations_@2X.png

syndaemon -k -i 0.5 -d
exec $SDF_STARTX_CMD
