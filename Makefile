DOCNAME=cv
DOCEXT=tex

ifeq ($(PREFIX),)
	PREFIX:= ./.
endif

.PHONY: $(DOCNAME).pdf all clean watch

all: $(DOCNAME).pdf

$(DOCNAME).pdf: $(DOCNAME).$(DOCEXT)
	latexmk -pdf -shell-escape -xelatex -use-make $(DOCNAME).$(DOCEXT)

watch: $(DOCNAME).$(DOCEXT)
	latexmk -pvc -pdf -shell-escape -xelatex -use-make $(DOCNAME).$(DOCEXT)

clean:
	latexmk -CA $(DOCNAME).$(DOCEXT)

install:
	cp $(DOCNAME).pdf $(PREFIX)
