#! /bin/bash



wid=$1
class=$2
instance=$3

log='/home/bhorrocks@corp.instructure.com/octobox/code/github.com/defektive/super-dot-files/home/.config/bspwm/log'
echo wid: $wid >> $log
echo class = $class >> $log
echo instance: $instance >> $log


if [ "$instance" == "keybase" ] ; then
	echo "keybase " >> $log
 	location=$(xprop -id "$wid" | grep location | awk '{print $5}')
	if [ "$location" == "0" ]; then
		echo float  >> $log
		echo "state=floating"
	fi
fi

if [ "$instance" == "slack" ] ; then
	echo "slack" >> $log
	slack_call=$(xprop -id $wid | grep "Slack Call Minipanel" 2>&1 1>/dev/null && echo found)
	if [ "$slack_call" == "found" ]; then
		echo float  >> $log
		echo "state=floating follow=off focus=off"
		xdotool windowsize $wid 570 230
		xdotool windowmove $wid 800 10
	fi
fi
