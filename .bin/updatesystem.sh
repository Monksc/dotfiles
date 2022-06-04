#!/usr/bin/env sh

if [ "$(cat /etc/*-release | awk -v'FS==' '$1=="DISTRIB_ID"{print $2}')" == "\"Arch\"" ]; then
    echo "Arch Linux"
    # sudo pacman -Syu
    yay -Syu
    # sudo pamac update && sudo pamac upgrade
fi

