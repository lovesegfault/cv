DOCNAME=cv

ifeq ($(PREFIX),)
	PREFIX:= ./.
endif

.PHONY: $(DOCNAME).pdf all clean

all: $(DOCNAME).pdf

$(DOCNAME).pdf: $(DOCNAME).xtx
	latexmk -pdf -xelatex -use-make $(DOCNAME).xtx

watch: $(DOCNAME).xtx
	latexmk -pvc -pdf -xelatex -use-make $(DOCNAME).xtx

clean:
	latexmk -CA $(DOCNAME).xtx

install:
	cp $(DOCNAME).pdf $(PREFIX)
