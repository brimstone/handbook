book.pdf: *.asciidoc Makefile
	docker run --rm -it -v ${PWD}:${PWD} -w ${PWD} brimstone/asciidoctor-pdf -dbook -o book.pdf -a revnumber=$(shell git describe --tags --always --dirty) -a revdate=$(shell date -I) book.asciidoc

.PHONY: image
image:
	docker build -t brimstone/asciidoctor-pdf .
