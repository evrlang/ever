#!/bin/bash

T2=$(which evr)
if [ -z "$T" ]; then
    git clone --depth 1 https://github.com/evrlang/ever
    
    cd ever
    chmod +x compile.sh
    ./compile.sh
else
    sudo rm "$T2"
    echo "clean out old install. run this installer again."
fi