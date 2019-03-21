FROM brimstone/debian:sid

RUN package asciidoctor ruby-asciidoctor-pdf

ENTRYPOINT ["asciidoctor-pdf"]
