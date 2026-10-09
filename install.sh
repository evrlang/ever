#!/bin/bash

T2=$(which evr)
if [ -z "$T2" ]; then
    git clone --depth 1 https://github.com/evrlang/ever
    
    cd ever
    chmod +x compile.sh
    ./compile.sh
    cd src
    if [ -f "evr" ]; then
       sudo install -m 755 evr /usr/local/bin/evr
    fi
else
    sudo rm "$T2"
    echo "clean out old install. run this installer again."
fi
