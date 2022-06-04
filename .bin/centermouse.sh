#!/usr/bin/env sh

monitorsize() {
    xrandr --prop | rg "^$1" | rg -o '[0-8]+x[0-9]+\+[0-9]+\+[0-9]+' | awk -v 'FS=[x+]' '{ print $'"$2"' }'
}

x=$(($(monitorsize $1 1) / 2 + $(monitorsize $1 3)))
y=$(($(monitorsize $1 2) / 2 + $(monitorsize $1 4)))

xdotool mousemove $x $y
