FIGURES_FOLDER := figures
PDFS := \
$(filter-out $(wildcard $(FIGURES_FOLDER)/*-crop.pdf),$(wildcard $(FIGURES_FOLDER)/*.pdf)) \
$(filter-out $(wildcard $(FIGURES_FOLDER)/**/*-crop.pdf),$(wildcard $(FIGURES_FOLDER)/**/*.pdf))
CROPPED_PDFS := $(PDFS:.pdf=-crop.pdf)

all: main.pdf main_plain.pdf $(CROPPED_PDFS)

%.pdf: %.tex Makefile
	pdflatex -synctex=1 -interaction=nonstopmode $<
	-bibtex $*.aux
	pdflatex -synctex=1 -interaction=nonstopmode $<
	pdflatex -synctex=1 -interaction=nonstopmode $<

%-crop.pdf: %.pdf Makefile
	pdfcrop $<

.PHONY: clean upgrade
clean:
	find . -maxdepth 1 \
		\( -name "*.aux" -o -name "*.bbl" -o -name "*.blg" -o \
	           -name "*.log" -o -name "*.out" -o -name "*.pdf" -o \
		   -name "*.synctex.gz" \) | xargs $(RM)
	find $(FIGURES_FOLDER) -name "*-crop.pdf" | xargs $(RM)

YEAR := 2022

upgrade:
	curl https://media.neurips.cc/Conferences/NeurIPS$(YEAR)/Styles/neurips_$(YEAR).sty -o neurips.sty
