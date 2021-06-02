DOCNAME=cv
DOCEXT=tex

ifeq ($(PREFIX),)
	PREFIX:= ./.
endif

.PHONY: $(DOCNAME).pdf all clean watch

all: $(DOCNAME).pdf

$(DOCNAME).pdf: $(DOCNAME).$(DOCEXT)
	latexmk -pdf -shell-escape -xelatex -use-make -output-directory=build $(DOCNAME).$(DOCEXT)

watch: $(DOCNAME).pdf
	latexmk -pvc -pdf -shell-escape -xelatex -use-make -output-directory=build $(DOCNAME).$(DOCEXT)

clean:
	rm -rf ./build

install: $(DOCNAME).pdf
	cp build/$(DOCNAME).pdf $(PREFIX)
