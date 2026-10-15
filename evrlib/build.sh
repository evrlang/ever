#make sure you have: ar, gcc, dmd, dub.

cd evrlib
gcc -fPIC -c evrlib.c graphic.c
cd ..
cd devrlib
rm -rf devrlib
mkdir devrlib
dub
cd devrlib
ar x ../libdevrlib.a
mv ../../evrlib/evrlib.o ../../evrlib/graphic.o .
gcc -shared *.o -L/usr/local/lib -L/usr/lib/x86_64-linux-gnu -lraylib -lphobos2 -lgcc_s -lGL -lm -lpthread -ldl -lrt -lX11 -o libevrlib.so
sudo mv libevrlib.so /usr/local/lib
sudo ldconfig