#!/usr/bin/env sh

echo $(($1+$(cat /sys/class/backlight/intel_backlight/actual_brightness))) > /sys/class/backlight/intel_backlight/brightness
# cat /sys/class/backlight/intel_backlight/actual_brightness

