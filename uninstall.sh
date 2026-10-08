
if [ -f "/usr/local/lib/libcbased.so" ]; then
    sudo rm /usr/local/lib/libcbased.so
    sudo ldconfig
    echo "libcbased.so removed."
fi

if [ -f "/usr/local/lib/libaxiom.a" ]; then
    sudo rm /usr/local/lib/libaxiom.a
    sudo ldconfig
    echo "libaxiom.a removed."
fi

if [ -f "/usr/local/lib/libevrlib.so" ]; then
    sudo rm /usr/local/lib/libevrlib.so
    sudo ldconfig
    echo "libevrlib.so removed."
fi

if [ -f "/usr/local/bin/evr" ]; then
    sudo rm /usr/local/bin/evr
    echo "evr removed."
fi