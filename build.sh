#! /bin/sh


(
	mkdir files
	cd files

	wget -q \
		"https://launchpadlibrarian.net/540974371/applet-window-buttons_2.0.9.0-0~202105290446~rev165~pkg3~ubuntu20.04.1_amd64.deb"
)


wget -qO nru https://raw.githubusercontent.com/Nitrux/nitrux-repository-util/master/nitrux-repository-util.sh
bash nru files/*
