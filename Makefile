all: main.pdf

%.pdf: %.tex
ifneq ($(wildcard *.bib),)
	pdflatex -synctex=1 -interaction=nonstopmode $<
	bibtex $*.aux
endif
	pdflatex -synctex=1 -interaction=nonstopmode $<
	pdflatex -synctex=1 -interaction=nonstopmode $<

.PHONY: clean upgrade
clean:
	find . -maxdepth 1 \
		\( -name "*.aux" -o -name "*.bbl" -o -name "*.blg" -o \
	           -name "*.log" -o -name "*.out" -o -name "*.pdf" -o \
		   -name "*.synctex.gz" \) | xargs $(RM)

YEAR := 2019

upgrade:
	wget https://media.neurips.cc/Conferences/NeurIPS$(YEAR)/Styles/neurips_$(YEAR).sty -O neurips.sty
	wget https://github.com/borisveytsman/acmart/raw/master/ACM-Reference-Format.bst \
		-O ACM-Reference-Format.bst
	wget http://ctan.mirror.rafal.ca/macros/latex/contrib/xurl/latex/xurl.sty -O xurl.sty
