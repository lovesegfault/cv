DOC := cv

ifeq ($(PREFIX),)
	PREFIX := ./.
endif

BUILD := build
TYPST_FLAGS ?=

.PHONY: default all
default all: pdf html

.PHONY: pdf html
pdf: $(BUILD)/$(DOC).pdf
html: $(BUILD)/$(DOC).html

$(BUILD)/$(DOC).pdf: $(DOC).typ content.typ
	@mkdir -p $(BUILD)
	typst compile $(TYPST_FLAGS) $< $@

$(BUILD)/$(DOC).html: $(DOC)-html.typ content.typ images/profilpicture.jpg
	@mkdir -p $(BUILD)
	typst compile --features html --format html $(TYPST_FLAGS) $< $@

.PHONY: watch
watch:
	@mkdir -p $(BUILD)
	typst watch $(TYPST_FLAGS) $(DOC).typ $(BUILD)/$(DOC).pdf

.PHONY: watch-html
watch-html:
	@mkdir -p $(BUILD)
	typst watch --features html --format html $(TYPST_FLAGS) $(DOC)-html.typ $(BUILD)/$(DOC).html

.PHONY: clean
clean:
	rm -rf $(BUILD)

.PHONY: install-pdf
install-pdf: pdf
	install -Dm644 -t $(PREFIX) $(BUILD)/$(DOC).pdf

.PHONY: install-html
install-html: html
	install -Dm644 -t $(PREFIX) $(BUILD)/$(DOC).html

.PHONY: install
install: install-pdf install-html
