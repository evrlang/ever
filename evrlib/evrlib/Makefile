#this file only work with gnu tools.

libevrlib.so: evrlib.c evrlib.h graphic.c graphic.h
	gcc -fPIC -shared evrlib.c graphic.c -lraylib -lGL -lm -lpthread -ldl -lrt -lX11 -o libevrlib.so 

clean: libevrlib.so
	rm libevrlib.so

install: libevrlib.so
	sudo mv libevrlib.so /usr/local/lib
	sudo ldconfig