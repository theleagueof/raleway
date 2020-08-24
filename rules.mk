PSAUTOHINT = $(shell echo cp $< $@) ; :

$(PROJECT)-report: $(VARIABLETTFS)
	xargs -n1 -iX gftools qa -f X -gfb --fontbakery --diffenator <<< $^
