#!/bin/sh

layout() {
	layout=$(xkblayout-state print "%s")
	echo "$layout"
}
ram() {
	mem=$(free -h | awk '/Mem:/ { print $3 }' | cut -f1 -d 'i')
	echo "$mem"
}

cpu() {
	read -r cpu a b c previdle rest < /proc/stat
	prevtotal=$((a+b+c+previdle))
	sleep 0.5
	read -r cpu a b c idle rest < /proc/stat
	total=$((a+b+c+idle))
	cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
	echo "$cpu"%
}



volume_alsa() {

	mono=$(amixer -M sget Master | grep Mono: | awk '{ print $2 }')

	if [ -z "$mono" ]; then
		muted=$(amixer -M sget Master | awk 'FNR == 6 { print $7 }' | sed 's/[][]//g')
		vol=$(amixer -M sget Master | awk 'FNR == 6 { print $5 }' | sed 's/[][]//g; s/%//g')
	else
		muted=$(amixer -M sget Master | awk 'FNR == 5 { print $6 }' | sed 's/[][]//g')
		vol=$(amixer -M sget Master | awk 'FNR == 5 { print $4 }' | sed 's/[][]//g; s/%//g')
	fi

	if [ "$muted" = "off" ]; then
		echo "muted"
	else
		if [ "$vol" -ge 65 ]; then
			echo "$vol%"
		elif [ "$vol" -ge 40 ]; then
			echo "$vol%"
		elif [ "$vol" -ge 0 ]; then
			echo "$vol%"	
		fi
	fi
}

clock() {
	dte=$(date +"%D")
	time=$(date +"%H:%M")

	echo "$dte $time"
}

main() {
	while true; do
		xsetroot -name "$(layout) | $(ram) | $(cpu) | $(clock)"
		sleep 1
	done
}

main
