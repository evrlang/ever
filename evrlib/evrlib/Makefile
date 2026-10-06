#this file only work with gnu tools.

libevrlib.so: evrlib.c evrlib.h
	gcc -fPIC -shared evrlib.c -o libevrlib.so

clean: libevrlib.so
	rm libevrlib.so

install: libevrlib.so
	sudo mv libevrlib.so /usr/local/lib