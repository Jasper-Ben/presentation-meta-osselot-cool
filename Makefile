# SPDX-License-Identifier:  CC0-1.0
MAKEFILE_PATH := $(abspath $(lastword ${MAKEFILE_LIST}))
MAKEFILE_DIR := $(dir ${MAKEFILE_PATH})

THEME ?= Generic

build: install-precommit-hook
	docker run --rm -e THEME=${THEME} -v ${MAKEFILE_DIR}:/mnt $$(docker build -q ${MAKEFILE_DIR})

install-precommit-hook:
	install -Dm 755 ${MAKEFILE_DIR}.pre-commit.sh ${MAKEFILE_DIR}.git/hooks/pre-commit
