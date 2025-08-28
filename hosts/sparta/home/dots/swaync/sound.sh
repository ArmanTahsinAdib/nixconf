#!/usr/bin/env bash

if [ $(swaync-client -D) = "false" ]; then
	canberra-gtk-play -i message
fi
