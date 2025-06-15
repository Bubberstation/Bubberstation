#!/bin/bash

# This script will deploy our modular icon assets so iconforge can use them in spritesheet generation
# This includes modular_zubbers/icons, modular_zubbers/master_files/icons, modular_skyrat/master_files/icons
# and a dynamically generated list of every module in modular_skyrat/modules that contains an icons folder
# If there ever comes a day where the modular_skyrat folder is organized so all the sprites are together
# instead of spread across modules, shed a tear of relief and remove the relevant code from here
directories=( $(find modular_skyrat/modules/ -type d -name "icons") )

mkdir -p \
    $1/modular_zubbers/icons \
	$1/modular_zubbers/master_files/icons \
	$1/modular_skyrat/master_files/icons \
	$1/modular_skyrat/modules/aesthetics \
	$1/modular_skyrat/modules/GAGS/json_configs \
	$1/modular_skyrat/modules/GAGS/nsfw/json_configs \
	$1/modular_zubbers/code/datums/greyscale/json_configs

cp -r modular_zubbers/icons/* $1/modular_zubbers/icons/
cp -r modular_zubbers/master_files/icons/* $1/modular_zubbers/master_files/icons/
cp -r modular_skyrat/master_files/icons/* $1/modular_skyrat/master_files/icons/
cp -r modular_skyrat/modules/aesthetics/* $1/modular_skyrat/modules/aesthetics/ # the aesthetics module doesnt use an icon folder but it does contain DMIs. God has abandoned us
cp -r modular_skyrat/modules/GAGS/json_configs/* $1/modular_skyrat/modules/GAGS/json_configs/
cp -r modular_skyrat/modules/GAGS/nsfw/json_configs/* $1/modular_skyrat/modules/GAGS/nsfw/json_configs/
cp -r modular_zubbers/code/datums/greyscale/json_configs/* $1/modular_zubbers/code/datums/greyscale/json_configs/


for icondir in ${directories[@]}
do
    mkdir -p $1/$icondir
	cp -r $icondir/* $1/$icondir/
done
