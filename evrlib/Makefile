# only for gnu tools
build: cbased/cbased.c cbased/cbased.h evrlib/evrlib.c evrlib/evrlib.h evrlib/graphic.h evrlib/graphic.c
	gcc -shared -fPIC cbased/cbased.c -o libcbased.so
	gcc -fPIC -shared evrlib/evrlib.c evrlib/graphic.c -lraylib -lGL -lm -lpthread -ldl -lrt -lX11 -o libevrlib.so 

libcbased.so: cbased/cbased.c cbased/cbased.h
	gcc -shared -fPIC cbased/cbased.c -o libcbased.so

libevrlib.so: evrlib/evrlib.c evrlib/graphic.c
	gcc -fPIC -shared evrlib/evrlib.c evrlib/graphic.c -lraylib -lGL -lm -lpthread -ldl -lrt -lX11 -o libevrlib.so 

install: libcbased.so libevrlib.so
	sudo mv libcbased.so /usr/local/lib
	sudo mv libevrlib.so /usr/local/lib

clean:
	rm libcbased.so
	rm libevrlib.so
