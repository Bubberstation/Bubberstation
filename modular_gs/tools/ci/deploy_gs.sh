#!/bin/bash

# This script will deploy our modular icon assets so iconforge can use them in spritesheet generation
# This includes modular_gs/icons and greyscale json configs

mkdir -p \
    $1/modular_gs/icons \

cp -r modular_gs/icons/* $1/modular_gs/icons/
