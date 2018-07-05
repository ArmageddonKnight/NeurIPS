all: main.pdf

PACKAGEs     := ./include/packages.tex
BIBTEX_FILEs := $(wildcard *.bib)
GRAPHs       := $(wildcard ./graphs/*)
CODE_BLOCKs  := $(wildcard ./code_blocks/*)

%.pdf: %.tex $(PACKAGEs) $(BIBTEX_FILEs) $(GRAPHs) $(CODE_BLOCKs)
ifneq ($(BIBTEX_FILEs),)
	pdflatex -synctex=1 -interaction=nonstopmode $<
	bibtex $*.aux
endif
	pdflatex -synctex=1 -interaction=nonstopmode $<
	pdflatex -synctex=1 -interaction=nonstopmode $<

.PHONY: clean
clean:
	find . -maxdepth 1 \
		\( -name "*.aux" -o -name "*.bbl" -o -name "*.blg" -o \
	           -name "*.log" -o -name "*.out" -o -name "*.pdf" -o \
		   -name "*.synctex.gz" \) | xargs $(RM)

.PHONY: push-include
push-include:
	git subtree push --prefix include https://github.com/ArmageddonKnight/Latex_Include master

.PHONY: pull-include
pull-include:
	git subtree pull --prefix include https://github.com/ArmageddonKnight/Latex_Include master --squash