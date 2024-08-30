#!/bin/sh
# SPDX-License-Identifier:  CC0-1.0

if git diff --name-only --staged | grep -q presentation-meta-osselot.md; then
    if [ -L "$(git rev-parse --show-toplevel)/beamerthemeiris" ] && [ -e "$(git rev-parse --show-toplevel)/beamerthemeiris" ]; then
        export THEME=Iris
    fi
    make -C "$(git rev-parse --show-toplevel)"
    git add "$(git rev-parse --show-toplevel)/presentation-meta-osselot.pdf"
fi
