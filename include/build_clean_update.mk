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
		   -name "*.nav" -o -name "*.snm" -o -name "*.toc" -o \
		   -name "*.synctex.gz" \) | xargs $(RM)

.PHONY: push-include pull-include template-update

push-include:
	-git add -A && git commit -m "Checkpoint before pushing include." && git push
	 git subtree push --prefix include https://github.com/ArmageddonKnight/Latex_Include master
	
pull-include:
	-git add -A && git commit -m "Checkpoint before pulling include." && git push
	 git subtree pull --prefix include https://github.com/ArmageddonKnight/Latex_Include master --squash

DOC_ROOT := $(shell pwd)
GIT_ROOT := $(shell git rev-parse --show-toplevel)

template-update:
	-git add -A && git commit -m "Checkpoint before template update." && git push
	 cd $(GIT_ROOT) && git subtree pull \
		--prefix=$(shell python -c "import os.path; print os.path.relpath('$(DOC_ROOT)', '$(GIT_ROOT)')") \
		https://github.com/ArmageddonKnight/$(TEMPLATE) master --squash
