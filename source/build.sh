#!/bin/sh
set -e


echo "Generating Static fonts"
mkdir -p ../fonts
fontmake -m Raleway-Roman.designspace -i -o ttf --output-dir ../fonts/ttf/
fontmake -m Raleway-Italic.designspace -i -o ttf --output-dir ../fonts/ttf/


echo "Generating VFs"
fontmake -m Raleway-Roman.designspace -o variable --output-path ../fonts/ttf/Raleway[wght].ttf
fontmake -m Raleway-Italic.designspace -o variable --output-path ../fonts/ttf/Raleway-Italic[wght].ttf

rm -rf master_ufo/ instance_ufo/ instance_ufos/*

