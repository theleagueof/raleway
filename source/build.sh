#!/bin/sh
set -e


echo "Generating VFs"
mkdir -p ../fonts/vf
fontmake -m Raleway-Roman.designspace -o variable --output-path ../fonts/vf/Raleway[wght].ttf
fontmake -m Raleway-Italic.designspace -o variable --output-path ../fonts/vf/Raleway-Italic[wght].ttf

rm -rf master_ufo/ instance_ufo/ instance_ufos/*


echo "Compiling VTT hints"
python -m vttLib mergefile vtt-hinting.ttx ../fonts/vf/Raleway[wght].ttf
python -m vttLib compile ../fonts/vf/Raleway[wght].ttf ../fonts/vf/Raleway[wght].fix  --ship
mv ../fonts/vf/Raleway[wght].fix ../fonts/vf/Raleway[wght].ttf

python -m vttLib mergefile vtt-hinting-italic.ttx ../fonts/vf/Raleway-Italic[wght].ttf
python -m vttLib compile ../fonts/vf/Raleway-Italic[wght].ttf ../fonts/vf/Raleway-Italic[wght].fix --ship
mv ../fonts/vf/Raleway-Italic[wght].fix ../fonts/vf/Raleway-Italic[wght].ttf


vfs=$(ls ../fonts/vf/*\[wght\].ttf)

echo "Post processing VFs"
for vf in $vfs
do
	gftools fix-dsig -f $vf;
	gftools fix-hinting $vf;
	mv $vf.fix $vf;
	gftools fix-gasp $vf --autofix;
	mv $vf.fix $vf;
done


echo "Fixing VF Meta"
gftools fix-vf-meta $vfs;


echo "Dropping MVAR"
for vf in $vfs
do
	mv "$vf.fix" $vf;
	ttx -f -x "MVAR" $vf; # Drop MVAR. Table has issue in DW
	rtrip=$(basename -s .ttf $vf)
	new_file=../fonts/vf/$rtrip.ttx;
	rm $vf;
	ttx $new_file
	rm $new_file
done


echo "Generating Static fonts"
mkdir -p ../fonts
fontmake -m Raleway-Roman.designspace -i -o ttf --output-dir ../fonts/ttf/
fontmake -m Raleway-Italic.designspace -i -o ttf --output-dir ../fonts/ttf/
fontmake -m Raleway-Roman.designspace -i -o otf --output-dir ../fonts/otf/
fontmake -m Raleway-Italic.designspace -i -o otf --output-dir ../fonts/otf/


echo "Post processing"
ttfs=$(ls ../fonts/ttf/*.ttf)
for ttf in $ttfs
do
	gftools fix-dsig -f $ttf;
	gftools fix-nonhinting $ttf $ttf.fix;
	mv "$ttf.fix" $ttf;
done


rm -rf master_ufo/ instance_ufo/ instance_ufos/* ../fonts/ttf/*gasp.ttf

