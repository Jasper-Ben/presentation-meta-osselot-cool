# Integrating OSSelot curation data into OpenEmbedded: Presenting meta-osselot

Presentation on the meta-osselot OpenEmbedded layer for [COOL](https://www.osadl.org/?id=4133#c19711).

The content of this presentation is made available under the terms of the [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).

Feel free to reuse and share in accordance to the license terms.

## Build

### System requirements

- GNU make
- Docker

### Building the presentation

1. Clone the repository. Only clone recursively if you are a employer of the iris company. Otherwise, you will see a "permission denied" error.

2. In the cloned repository folder run `make`.

This will build the docker image required for building the presentation and use this in turn to build the pdf.

Note, that for trademark reasons I cannot include the original theme. Therefore a more generic beamer theme is used instead. Feel free to adjust this theme to your needs.
