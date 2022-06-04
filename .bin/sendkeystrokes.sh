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
if [ "$1" == "deletetab" ]; then
    action=4
fi
if [ "$1" == "startofword" ]; then
    action=5
fi
if [ "$1" == "endofword" ]; then
    action=6
fi

sendkey() {
    xdotool windowactivate --sync $(xdotool getactivewindow) "$1" "$2"
}

sendctrl() {
    if [ "$1" == 1 ]; then
        sleep $sleeptime
        sendkey keyup 'Alt'
        sendkey key 'CTRL+c'
        sendkey keydown 'Alt'
    elif [ "$1" == 2 ]; then
        sleep $sleeptime
        sendkey keyup 'Alt'
        sendkey key 'CTRL+v'
        sendkey keydown 'Alt'
    elif [ "$1" == 3 ]; then
        sendkey key 'CTRL+y'
    elif [ "$1" == 4 ]; then
        sendkey key 'CTRL+w'
    elif [ "$1" == 5 ]; then
        sendkey key 'CTRL+a'
    fi
}

sendctrlshift() {
    sendkey keyup Alt
    if [ "$1" == 1 ]; then
        sleep $sleeptime
        sendkey keyup Alt
        sendkey key 'CTRL+C'
    elif [ "$1" == 2 ]; then
        sleep $sleeptime
        sendkey keyup Alt
        sendkey key 'CTRL+V'
    elif [ "$1" == 3 ]; then
        sendkey key 'CTRL+w'
    elif [ "$1" == 4 ]; then
        sendkey key 'Alt+w'
    elif [ "$1" == 5 ]; then
        sendkey key 'CTRL+a'
    elif [ "$1" == 6 ]; then
        sendkey key 'CTRL+e'
    else
        sendkey "$@"
    fi
}

sendsurfkeys() {
    sendkey keyup Alt
    if [ "$1" == 1 ]; then
        sleep $sleeptime
        sendkey keyup Alt
        sendkey key 'Alt+C'
    elif [ "$1" == 2 ]; then
        sleep $sleeptime
        sendkey keyup Alt
        sendkey key 'CTRL+V'
    elif [ "$1" == 3 ]; then
        sendkey key 'CTRL+w'
    else
        sendkey "$@"
    fi
}


if [ "$name" == "surf" ]; then
    sendsurfkeys "$action"
elif [ "$name" == "Alacritty" ]; then
    sendctrlshift "$action"
else
    sendctrl "$action"
fi

