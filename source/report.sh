#!/bin/sh
set -e


gftools qa -f ../fonts/vf/Raleway[wght].ttf  -gfb --fontbakery --diffenator -o ../fonts/vf/out_roman

gftools qa -f ../fonts/vf/Raleway-Italic[wght].ttf  -gfb --fontbakery --diffenator -o ../fonts/vf/out_italic



# gftools qa -f ../fonts/vf/Raleway[wght].ttf  -gfb --fontbakery -o ../fonts/vf/out_roman

# gftools qa -f ../fonts/vf/Raleway-Italic[wght].ttf  -gfb --fontbakery  -o ../fonts/vf/out_italic