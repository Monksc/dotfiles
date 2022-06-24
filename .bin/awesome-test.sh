#!/usr/bin/env sh

Xephyr :5 -screen 1500x1024 & sleep 1 ; DISPLAY=:5 awesome
