#!/usr/bin/env bash

sleeptime=0.1

name=$(xdotool getwindowname $(xdotool getwindowfocus))

action=0
if [ "$1" == "copy" ]; then
    action=1
fi
if [ "$1" == "paste" ]; then
    action=2
fi
if [ "$1" == "deletebackwords" ]; then
    action=3
fi

sendctrl() {
    if [ "$1" == 1 ]; then
        sleep $sleeptime
        xdotool keyup 'Alt'
        xdotool key 'CTRL+c'
        xdotool keydown 'Alt'
    elif [ "$1" == 2 ]; then
        sleep $sleeptime
        xdotool keyup 'Alt'
        xdotool key 'CTRL+v'
        xdotool keydown 'Alt'
    elif [ "$1" == 3 ]; then
        xdotool key 'CTRL+y'
    fi
}

sendctrlshift() {
    xdotool keyup Alt
    if [ "$1" == 1 ]; then
        sleep $sleeptime
        xdotool keyup Alt
        xdotool key 'CTRL+C'
    elif [ "$1" == 2 ]; then
        sleep $sleeptime
        xdotool keyup Alt
        xdotool key 'CTRL+V'
    elif [ "$1" == 3 ]; then
        xdotool key 'CTRL+w'
    else
        sendctrl "$@"
    fi
}


if [ "$name" == "Alacritty" ]; then
    sendctrlshift "$action"
else
    sendctrl "$action"
fi

