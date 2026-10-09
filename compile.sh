#!/bin/bash

T=$(which dialog)

if [ -z "$T" ]; then
	#support ubuntu-apt based system.
	sudo apt install dialog
fi

clear

dialog --msgbox $'Welcome to Ever Programming language installer for linux!\nPleases not that installer now support only apt-based system.\nRead: https://evrlang.github.io/ever/wiki/tools/installer.html' 10 60 
clear

if [ -f "/usr/local/lib/libcbased.so" ]; then
	if [ -f "/usr/local/lib/libevrlib.so" ]; then
		if [ -f "/usr/local/lib/libaxiom.a" ]; then
			cd src
			dub
			if [ -f "evr" ]; then
				echo "(1) Build Done."
			else
				echo "(1) Build done with errors."
			fi
			#sudo mv evr /usr/local/bin
		else
			cd src/axiom
			dub
			sudo mv libaxiom.a /usr/local/lib
			echo "run compile.sh again."
		fi
	else
		cd evrlib/evrlib
		make
		sudo mv libcbased.so /usr/local/lib
		sudo ldconfig
		cd ../..
		echo "run compile.sh again."
	fi
else 
	cd evrlib
	make libcbased.so
	make libevrlib.so
	sudo mv libcbased.so /usr/local/lib
	sudo mv libevrlib.so /usr/local/lib
	sudo ldconfig
	cd ..
	echo "run compile.sh again."
fi
