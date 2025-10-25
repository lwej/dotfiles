#!/usr/bin/env bash
img="$HOME/.cache/i3lock.png"

scrot $img
convert "$img" -scale 10% -scale 1000% -modulate 100,50 -scale 5000x500% "$img"
i3lock -i $img

rm $img
