HINT =

$(PROJECT)-report: $(VARIABLETTFS)
	echo -n $^ | xargs -d' ' -n1 -iX gftools qa -f X -gfb --fontbakery --diffenator
