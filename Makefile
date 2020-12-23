manual.pdf: *.asciidoc */*asciidoc Makefile custom-theme.yml
	docker run --rm -it -v ${PWD}:${PWD} -w ${PWD} brimstone/asciidoctor-pdf \
	asciidoctor-pdf -a pdf-style=custom-theme.yml -o manual.pdf -a revnumber=$(shell git describe --tags --always --dirty) -a revdate=$(shell date -I) --trace manual.asciidoc
	@echo "Done"

booklet.pdf: Makefile manual.pdf booklet.latex
	docker run --rm -it -v ${PWD}:${PWD} -w ${PWD} brimstone/asciidoctor-pdf pdflatex booklet.latex
	rm -f booklet.log booklet.aux

all: booklet.pdf

.PHONY: clean
clean:
	rm -f *.pdf booklet.log booklet.aux

.PHONY: image
image:
	docker build -t brimstone/asciidoctor-pdf .

.PHONY: watch
watch:
	find . -type f \( -iname Makefile -o -iname '*.yml' -o -iname '*.asciidoc' \) | entr -c make
