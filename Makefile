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

YEAR := 2021

upgrade:
	curl https://media.neurips.cc/Conferences/NeurIPS$(YEAR)/Styles/neurips_$(YEAR).sty -o neurips.sty
	curl https://github.com/borisveytsman/acmart/raw/master/ACM-Reference-Format.bst \
		-o ACM-Reference-Format.bst
	curl http://ctan.mirror.rafal.ca/macros/latex/contrib/xurl/latex/xurl.sty -o xurl.sty
