all: main.pdf

YEAR := $(shell date +%Y)

INCLUDEs     := $(wildcard ./include/*)
BIBTEX_FILEs := $(wildcard *.bib)
GRAPHs       := $(wildcard ./graphs/*)
CODE_BLOCKs  := $(wildcard ./code_blocks/*)

%.pdf: %.tex $(INCLUDEs) $(BIBTEX_FILEs) $(GRAPHs) $(CODE_BLOCKs)
ifneq ($(BIBTEX_FILEs),)
	pdflatex -synctex=1 -interaction=nonstopmode $<
	bibtex $*.aux
endif
	pdflatex -synctex=1 -interaction=nonstopmode $<
	pdflatex -synctex=1 -interaction=nonstopmode $<

.PHONY: clean
clean:
	find . \( -name "*.aux" -o -name "*.bbl" -o -name "*.blg" -o \
	          -name "*.log" -o -name "*.out" -o -name "*.synctex.gz" -o \
	       \( -name "*.pdf" -a -not -path "./graphs/*" \) \) | xargs $(RM)

.PHONY: update
update:
	wget https://media.nips.cc/Conferences/NIPS$(YEAR)/Styles/nips_$(YEAR).sty -O nips.sty
	wget https://github.com/borisveytsman/acmart/raw/master/ACM-Reference-Format.bst \
		-O ACM-Reference-Format.bst
	git submodule update --init && cd include && git checkout master && git pull
