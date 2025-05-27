DOC=cv

ifeq ($(PREFIX),)
	PREFIX:= ./.
endif

default all: $(DOC).pdf

$(DOC).pdf: $(DOC).tex
	latexmk $(DOC).tex

watch: $(DOC).pdf
	latexmk -pvc $(DOC).tex

.PHONY: clean
clean:
	rm -rf build/
	rm -f indent.log
	rm -f $(DOC).bak0

.PHONY: install
install: $(DOC).pdf
	cp build/$(DOC).pdf $(PREFIX)
