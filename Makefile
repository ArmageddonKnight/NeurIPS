TEMPLATE := NIPS

all: main.pdf

%.pdf: %.tex
ifneq ($(wildcard *.bib),)
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

.PHONY: template-update style-update

DOC_ROOT := $(shell pwd)
GIT_ROOT := $(shell git rev-parse --show-toplevel)

template-update:
	-git add -A && git commit -m "Checkpoint before template update [ci skip]." && git push
	 cd $(GIT_ROOT) && git subtree pull \
		--prefix=$(shell python -c "import os.path; print os.path.relpath('$(DOC_ROOT)', '$(GIT_ROOT)')") \
		https://github.com/ArmageddonKnight/$(TEMPLATE) master --squash

YEAR := $(shell date +%Y)

style-update:
	wget https://media.nips.cc/Conferences/NIPS$(YEAR)/Styles/nips_$(YEAR).sty -O nips.sty
	wget https://github.com/borisveytsman/acmart/raw/master/ACM-Reference-Format.bst \
		-O ACM-Reference-Format.bst
