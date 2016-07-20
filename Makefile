MAKEFLAGS += -r
ROOT := $(abspath $(CURDIR))
export ROOT

DESTDIR ?= $(ROOT)/dist
PREFIX ?= $(ROOT)
export DESTDIR PREFIX

# Programs used
CC              ?= $(CROSS_COMPILE)gcc
CPP             ?= $(CC) -E
INSTALL         ?= install
INSTALL_DATA    ?= $(INSTALL) -m 644
INSTALL_PROGRAM ?= $(INSTALL)
LD              ?= $(CROSS_COMPILE)ld
OBJCOPY         ?= $(CROSS_COMPILE)objcopy
PYTHON          ?= python

export CC CPP INSTALL INSTALL_DATA INSTALL_PROGRAM LD OBJCOPY PYTHON

.PHONY: all
all:
	@set -e; for D in $(wildcard tests/*); do \
		[ ! -e $$D/Makefile ] && continue; \
		$(MAKE) -C $$D build; \
	done

.PHONY: install
install:
	@mkdir -p $(DESTDIR)
	$(INSTALL_PROGRAM) -p xtf-runner $(DESTDIR)
	@set -e; for D in $(wildcard tests/*); do \
		[ ! -e $$D/Makefile ] && continue; \
		$(MAKE) -C $$D install; \
	done

.PHONY: cscope
cscope:
	find include/ arch/ common/ tests/ -name "*.[hcsS]" > cscope.files
	cscope -b -q -k

.PHONY: clean
clean:
	find . \( -name "*.o" -o -name "*.d" -o -name "*.lds" \) -delete
	find tests/ \( -perm -a=x -name "test-*" -o -name "test-*.cfg" \
		-o -name "test-info.json" \) -delete

.PHONY: distclean
distclean: clean
	find . \( -name "*~" -o -name "cscope*" \) -delete
	rm -rf docs/autogenerated/ dist/

.PHONY: doxygen
doxygen: Doxyfile
	doxygen Doxyfile > /dev/null

.PHONY: pylint
pylint:
	-pylint --rcfile=.pylintrc xtf-runner
