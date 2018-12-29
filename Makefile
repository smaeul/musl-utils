#
# Copyright © 2016-2018 Samuel Holland <samuel@sholland.org>
# SPDX-License-Identifier: 0BSD
#

STRINGS	?= $(CROSS_COMPILE)strings

PREFIX	?= /usr
LDSO	:= $(PREFIX)/lib/libc.so
ARCH	:= $(shell $(STRINGS) $(LDSO) |& sed -n 's/^musl libc (\(.*\))$$/\1/p')

all: ldconfig

clean:
	rm -f ldconfig

install:
	$(INSTALL) -Dm755 ldconfig $(DESTDIR)$(PREFIX)/sbin/ldconfig

ldconfig: ldconfig.in
	sed 's/@@ARCH@@/$(ARCH)/g' $< > $@.tmp || rm -f $@.tmp
	chmod 755 $@.tmp
	mv $@.tmp $@

.PHONY: all clean install
