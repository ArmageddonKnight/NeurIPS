all: main.pdf

YEAR := $(shell date +%Y)

BIBTEX_FILEs := $(wildcard *.bib)
GRAPHs := $(wildcard ./graphs/*)
CODE_BLOCKs := $(wildcard ./code_blocks/*)

%.pdf: %.tex $(BIBTEX_FILEs) $(GRAPHs) $(CODE_BLOCKs)
ifneq ($(BIBTEX_FILEs),)
	pdflatex -synctex=1 -interaction=nonstopmode $<
	bibtex $*.aux
endif
	pdflatex -synctex=1 -interaction=nonstopmode $<
	pdflatex -synctex=1 -interaction=nonstopmode $<

.PHONY: clean
clean:
	find . \( -name "*.aux" -o -name "*.bbl" -o -name "*.blg" -o \
	          -name "*.log" -o -name "*.out" -o -name "*.synctex.gz" \) -o \
	       \( -name "*.pdf" -a -not -path "./graphs/*" -a -not -path "./acmart/*" \) | xargs $(RM)

.PHONY: style-upgrade
style-upgrade:
	wget https://media.nips.cc/Conferences/NIPS$(YEAR)/Styles/nips_$(YEAR).sty -O nips.sty
