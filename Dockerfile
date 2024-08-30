# SPDX-License-Identifier:  CC0-1.0
FROM alpine:3.17

RUN apk add --no-cache \
    pandoc \
    texlive-luatex \
    texmf-dist-fontsextra \
    texmf-dist-latexextra

ENV THEME=Generic
WORKDIR /mnt
CMD /usr/bin/pandoc presentation-meta-osselot.md -t beamer --pdf-engine lualatex -V theme=$THEME -o presentation-meta-osselot.pdf
