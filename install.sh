#!/bin/bash

T2=$(which evr)
if [ -z "$T" ]; then
    git clone --depth 1 https://github.com/evrlang/ever
    
    cd ever
    chmod +x compile.sh
    ./compile.sh
    cd src
    if [ -f "evr" ]; then
        echo "Do you want to install it for all users of this pc? (this need sudo)[Y,N]"
        read answer
        if [ "$answer" == "Y" ]; then
            sudo mv evr /usr/local/bin
        fi
    fi
else
    sudo rm "$T2"
    echo "clean out old install. run this installer again."
fi
