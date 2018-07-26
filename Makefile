include include/build_clean_update.mk

YEAR := $(shell date +%Y)

.PHONY: style-update
style-update: pull-include
	wget https://media.nips.cc/Conferences/NIPS$(YEAR)/Styles/nips_$(YEAR).sty -O nips.sty
	wget https://github.com/borisveytsman/acmart/raw/master/ACM-Reference-Format.bst \
		-O ACM-Reference-Format.bst
