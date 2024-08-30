# SPDX-License-Identifier:  CC0-1.0
MAKEFILE_PATH := $(abspath $(lastword ${MAKEFILE_LIST}))
MAKEFILE_DIR := $(dir ${MAKEFILE_PATH})

THEME ?= Generic

build:
	docker run --rm -e THEME=${THEME} -v ${MAKEFILE_DIR}:/mnt $$(docker build -q ${MAKEFILE_DIR})
