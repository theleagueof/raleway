#!/bin/sh
set -e


## run reports for fontbakery and diffenator for roman and italic
gftools qa -f ../fonts/vf/Raleway[wght].ttf  -gfb --fontbakery --diffenator -o ../fonts/vf/out_roman
gftools qa -f ../fonts/vf/Raleway-Italic[wght].ttf  -gfb --fontbakery --diffenator -o ../fonts/vf/out_italic
