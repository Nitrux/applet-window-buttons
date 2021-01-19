#! /bin/sh


(
	mkdir files
	cd files

	wget -q \
		"https://launchpad.net/~krisives/+archive/ubuntu/applet-window-buttons/+files/applet-window-buttons_2.0.8.0-0~202012310003~rev156~pkg3~ubuntu20.04.1_amd64.deb"
)


wget -qO nru https://raw.githubusercontent.com/Nitrux/nitrux-repository-util/master/nitrux-repository-util.sh
bash nru files/*
