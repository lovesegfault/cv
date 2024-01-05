DOCNAME=cv
DOCEXT=tex

ifeq ($(PREFIX),)
	PREFIX:= ./.
endif

.PHONY: $(DOCNAME).pdf all clean watch

all: $(DOCNAME).pdf

$(DOCNAME).pdf: $(DOCNAME).$(DOCEXT)
	latexmk -pdf -shell-escape -xelatex -use-make $(DOCNAME).$(DOCEXT)

watch: $(DOCNAME).pdf
	latexmk -pvc -pdf -shell-escape -xelatex -use-make $(DOCNAME).$(DOCEXT)

clean:
	rm result || true
	rm -rf ./build || true
	rm *.aux || true
	rm *.fdb_latexmk || true
	rm *.fls || true
	rm *.log || true

install: $(DOCNAME).pdf
	cp build/$(DOCNAME).pdf $(PREFIX)
